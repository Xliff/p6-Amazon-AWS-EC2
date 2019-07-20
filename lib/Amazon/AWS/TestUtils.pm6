use v6.d;

use Test;

use File::Find;

use Amazon::AWS::Utils;

use Amazon::AWS::EC2::Types::Base;
use Amazon::AWS::Roles::Base;
use XML::Class;

use Data::Dump::Tree;

unit package Amazon::AWS::TestUtils;

my $DEBUG = $*ENV<P6_AMAZON_DEBUG>;

class X::NoAttributesRemaining is Exception { }

sub diff ($da, $db) is export {
  use File::Temp;

  diag $da;                      diag $db;
  my ($dfan, $dfah) = tempfile;  my ($dfbn, $dfbh) = tempfile;
  $dfah.spurt($da, :close);      $dfbh.spurt($db, :close);
  say qqx{diff $dfan $dfbn};
}

sub getTestFiles($cat, :$unit) is export {
  # Could have done this...
  #
  # my $lib = 'lib';
  # $lib = "../{$lib}" unless $lib.IO.d;
  #
  # my @files = find dir => $lib, name => /'.pm6' $/;
  #
  # for @files.map( *.relative.split('/')[1..* - 1].join('::').substr(0, *-4) ) {
  #   next unless .starts-with('Amazon::AWS::EC2::Types');
  # }

  # Let's do this, instead!
  my $buildList = 'BuildList';
  $buildList = '../BuildList' unless $buildList.IO.e;

  die 'Cannot find BuildList file' unless $buildList.IO.e;

  my @files = $buildList.IO
                        .slurp
                        .lines;

  # Load and preserve all roles.
  # my %roles = (do gather for @files -> $f {
  #   if $f.defined && $f ~~ / '::Roles::' / {
  #     CATCH { default { die "Cannot load Role '{$f}':\n\t{ .message }" } }
  #     my $m = (require ::($f));
  #     say "Loaded role '{$f}'..." if $DEBUG;
  #     take Pair.new( $f, ::($f) )
  #   }
  # }).Hash;
  # %roles.gist.say;

  @files .= grep({
    .defined
    &&
    .starts-with("Amazon::AWS::EC2::{$cat}")
    &&
    not .ends-with('Base')
  });

  if $unit.defined {
    @files .= grep({ .split('::')[* - 1] eq $unit.split(',').any });
    #@files .= grep( *.contains($unit) );
    die "Could not find '{ $unit }' in { $cat }'" unless @files;
  }

  @files;
}

sub changeRandomAttribute($o is rw) is export {
  my $victim;
  my @options = $o.^attributes
                  .grep({ 
                    .WHY.defined.not && 
                    .name.defined    && 
                    .name.chars      
                  });
  # Must put the next line inside an elements check, or an undefined
  # value will be created.
  @options .= map({ .name.substr(2) }) if @options;
  X::NoAttributesRemaining.new.throw unless @options;
  repeat {
    $victim = @options.pick;
  } until $o."$victim"() ~~
    (Str, Bool, Num, Int, Positional, Amazon::AWS::Roles::Eqv).any;

  #diag "{ $o.^attributes.map({ (.name // '$!WTF').substr(2) }).join(', ') }";
  #diag "$victim -- { $victim.^name }";

  my $val = $o."$victim"();
  #diag "$victim = $val";
  my $newVal = do given $val {
    when Str                            { "syzygy!" ~ ($_ // '')  }   # 3 Wyse, Man
    when Bool                           { .not                    }
    when Int                            { ++$_                    }
    when Num                            { $_ + 2.5                }
    when Positional                     { $val.WHAT.new           }
    when  Amazon::AWS::Roles::Eqv       |
          Amazon::AWS::EC2::Types::Base { $val.WHAT.new           }
    default                             { die "WTF?: { .^name }"  }
  }
  # diag "Setting {$victim} to {$newVal.gist}";
  $o."$victim"() = $val ~~ Positional ?? $newVal.Array !! $newVal;
  $o;
}

# Must be global for duration of execution.
my %classes;
my (%timings, $benchmark-real-start, $benchmark-iterations);
my ($benchmark-start, $benchmark-lev);

# Use only if you have LOTS of loops!
#constant exp = 10
constant exponent = 5;

# Potential change:
# Can remove exponent constant and that functionality can be set by the 
# end-user with a parameter on startTiming...
sub startTiming is export {
  ($benchmark-start, 
   $benchmark-real-start, 
   $benchmark-iterations, 
   $benchmark-lev) = (DateTime.now, DateTime.now, 0, 0);
}

# If you really want speed, this needs to be in nqp!
sub checkNextTiming is export {
  if $benchmark-iterations++ > (my $exp = exponent ** $benchmark-lev) {
    %timings{$exp} = DateTime.now - $benchmark-start;
    %timings{$exp} /= exponent if $exp > 1;
    $benchmark-start = DateTime.now;
    $benchmark-lev++;
  }
}

sub finishTiming is export {
  my $end = DateTime.now;
  %timings{$benchmark-iterations} = $end - $benchmark-start;
  #my $log-last = $benchmark-iterations.log(exponent) 
  #%timings{$benchmark-iterations} /= exponent if $log-last =~= $log-last.floor;
  %timings{$benchmark-iterations} /= exponent if %timings.elems > 1;
  diag %timings.pairs.sort( *.key.Int ).map( *.gist ).join(' / ');
  diag "Total time: { $end - $benchmark-real-start }s";
}

sub doBasicTests(
  @files, 
  :$elems = 1, 
  :$number = 1,
  :$do-timings = True
) is export {
  my ($elev, $timeStart) = (0, DateTime.now);
  
  plan @files.elems * 8 * $number;
  
  startTiming if $do-timings;
  NUMLOOP: for ^$number {  
    checkNextTiming if $do-timings;
    
    for @files {
      CATCH { default { diag .message } }
      
      my ($class, $a, $bx, $b, $tl, $te, $na);
      
      %classes{$_} := (try require ::($ = "$_")) if not %classes{$_}:exists;
      
      $class := %classes{$_};
         
      ok         ($tl = $class !~~ Failure),             "$_ loads. Is not a Failure object";
      ok         ($te = $class !=:= Nil),                "$_ exists";
      ok         ($na = $class.^name ne 'Any'),          "$_ is not (Any)";
      
      # Attempt to speed things up.
      %classes{$_} := $class if $tl && $te;
      if $tl.not || $te.not || $na.not {
        diag %classes.gist;
        skip-rest 'One if the first three tests failed, so no further tests needed';
        last NUMLOOP;
      }     

      lives-ok {
        CATCH { 
          default {
            diag $class.^name;
            diag $class.HOW;
            diag %classes{$_}.gist;
            diag .message unless .message eq 'Undefined object';
            .rethrow
          }
        }
        my $ci = %classes{$_}.new;
        #diag "CI: { $ci.gist }";
        $a = populateTestObject( $ci, :$elems, :!blanks )
      },                                                            "$_ can be populated";
      lives-ok { 
        CATCH { 
          default { diag .message } 
        }
        $bx = $a.to-xml                                        },   "$_ serializes ok";
      # diag $bx;
      lives-ok { 
        CATCH { 
          default { diag .message } 
        }
        $b = $class.from-xml($bx)                              },   "$_ deseralizes ok";
      
      ok       ( my $eqv = $a.eqv($b) ),                            "$_ compares ok";
      
      unless $eqv {
        diag $bx;
        diff( ddt($a, :get), ddt($b, :get) )
      }
      
      {
        CATCH { 
          when X::NoAttributesRemaining {
            pass 'No atributes left to change, so skipping...';
          }
        }
        changeRandomAttribute($b);
        nok do { $a.eqv($b)                                    },   "Changed $_ fails eqv";
      }
    }
  }
  finishTiming if $do-timings;
}
