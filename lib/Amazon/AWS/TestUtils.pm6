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

sub changeRandomAttribute($o is rw) {
  my $victim;
  repeat {
    $victim = $o.^attributes
                .map({ .name.substr(2) })
                .grep({ .defined && .chars})
                .pick;
  } until $o."$victim"() ~~
    (Str, Bool, Int, Positional, Amazon::AWS::EC2::Types::Base).any;

  #diag "{ $o.^attributes.map({ (.name // '$!WTF').substr(2) }).join(', ') }";
  #diag "$victim -- { $victim.^name }";

  my $val = $o."$victim"();
  #diag "$victim = $val";
  my $newVal = do given $val {
    when Str                           { "syzygy!" ~ ($_ // '') }   # 3 Wyse, Man
    when Bool                          { .not                   }
    when Int                           { ++$_                   }
    when Positional                    { $val.WHAT.new          }
    when Amazon::AWS::EC2::Types::Base { $val.WHAT.new          }
    default                            { die 'WTF?!?'           }
  }
  # diag "Setting {$victim} to {$newVal.gist}";
  $o."$victim"() = $val ~~ Positional ?? $newVal.Array !! $newVal;
}

sub doBasicTests(@files, :$number) is export {
  plan @files.elems * 7 * $number;

  for ^$number {
    for @files {
      CATCH { default { diag .message } }

      my ($class, $a, $bx, $b);

      $class := (try require ::($_));

      ok         $class !~~ Failure,                                "$_ loads. Is not a Failure object";
      ok         $class !=:= Nil,                                   "$_ exists";
      lives-ok {
        CATCH {
          default {
            $class.^name.say;
            $class.HOW.say;
            diag .message;
            .rethrow
          }
        }
        $a = populateTestObject(::($_).new, :!blanks)
      },                                                            "$_ can be populated";
      lives-ok { $bx = $a.to-xml                               },   "$_ serializes ok";
      # diag $bx;
      lives-ok { $b = $class.from-xml($bx)                     },   "$_ deseralizes ok";
      ok       $a.eqv($b),                                          "$_ compares ok";
      # diag ddt($a, :get);
      nok      do { changeRandomAttribute($b); $a eqv $b       },   "Changed $_ fails eqv";
      # diag ddt($b, :get);
    }
  }
}
