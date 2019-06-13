use v6.d;

use Test;

use File::Find;

use Amazon::AWS::Utils;

use Amazon::AWS::EC2::Types::Base;
use Amazon::AWS::Roles::Base;
use XML::Class;

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
    @files .= grep({ .contains($unit) });
    die "Could not find '{ $unit }' in { $cat }'" unless @files;
  }

  @files;
}

# sub changeRandomAttribute($o) {
#   my $victim;
#   repeat {
#     $victim = $o.^attributes
#                 .map({ .name.substr(2) })
#                 .grep({ .defined && .chars})
#                 .pick;
#   } until $o."$victim"() ~~ (Str, Bool, Int, Amazon::AWS::EC2::Types::Base).any;
#
#   diag "{ $o.^attributes.map({ (.name // '$!WTF').substr(2) }).join(', ') }";
#   diag "$victim -- { $victim.^name }";
#
#   my $val = $o."$victim"();
#   my $newVal = do given $val {
#     when Str                           { "syzygy!" ~ ($_ // '') }   # 3 Wyse, Man
#     when Int                           { ++$_                   }
#     when Bool                          { .not                   }
#     when Positional                    { ($val.WHAT.new)        }
#     when Amazon::AWS::EC2::Types::Base { $val.WHAT.new          }
#     default                            { die 'WTF?!?'           }
#   }
#   diag "Setting {$victim} to {$newVal.gist}";
#   $o."$victim"() = $newVal;
# }

sub doBasicTests(@files) is export {
  plan @files.elems * 5;

  for @files {
    CATCH { default { diag .message } }

    my ($class, $a, $bx, $b);

    $class := (try require ::($_));

    ok         $class !~~ Failure,                                "$_ loads. Is not a Failure object";
    ok         $class !=:= Nil,                                   "$_ exists";
    lives-ok { $a = populateTestObject($class.new, :!blanks) },   "$_ can be populated";
    lives-ok { $bx = $a.to-xml                               },   "$_ serializes ok";
    lives-ok { $b = $class.from-xml($bx)                     },   "$_ deseralizes ok";
    #ok       $a.eqv($b),                                         "$_ compares ok";
    #nok      do { changeRandomAttribute($b); $a eqv $b       },  "Changed $_ fails eqv";
  }
}
