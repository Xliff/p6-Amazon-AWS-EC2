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
    @files .= grep({ .split('::')[* - 1] eq $unit });
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

sub doBasicTests(@files, :$elems = 1, :$number = 1) is export {
  plan @files.elems * 8 * $number;
  my ($elev, $timeStart) = (0, DateTime.now);
  my %timings;

  my $iteration;
  for ^$number {
    # If you really want speed, this needs to be in nqp!
    if $iteration++ > (my $exp = 10 ** $elev) {
      %timings{$exp} = DateTime.now - $timeStart;
      $timeStart = DateTime.now;
      $elev++;
    }
    for @files {
      CATCH { default { diag .message } }
      
      my ($class, $a, $bx, $b, $tl, $te);
 
      (%classes{$_} = try require ::($_)) if not %classes{$_}:exists;
      $class := %classes{$_};
         
      ok         ($tl = $class !~~ Failure),             "$_ loads. Is not a Failure object";
      ok         ($te = $class !=:= Nil),                "$_ exists";
      ok         $class.HOW.^name.ends-with('ClassHOW'), "$_ is a class";
      
      # Attempt to speed things up.
      %classes{$_} := $class if $tl && $te;

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
        die 'Undefined object' unless $a.^name ne 'Any';
        $a = populateTestObject( %classes{$_}.new, :$elems, :!blanks )
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
      
      diff( ddt($a, :get), ddt($b, :get) ) unless $eqv;
      
      {
        CATCH { 
          when X::NoAttributesRemaining {
            pass 'No atributes left to change, so skipping...';
          }
        }
        changeRandomAttribute($b);
        nok do { $a eqv $b                                     },   "Changed $_ fails eqv";
      }
    }
  }
  %timings{$iteration} = DateTime.now - $timeStart;
  diag %timings.gist;
}
