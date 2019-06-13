use v6.c;

use Test;

use File::Find;

use Amazon::AWS::Utils;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;

sub MAIN (:$unit) {

  my $DEBUG = $*ENV<P6_AMAZON_DEBUG>;

  my $buildList = 'BuildList';
  $buildList = '../BuildList' unless $buildList.IO.e;

  die 'Cannot find BuildList file' unless $buildList.IO.e;

  my @files = $buildList.IO
                        .slurp
                        .lines;

  @files .= grep({
    .defined
    &&
    .starts-with('Amazon::AWS::EC2::Action')
    &&
    not .ends-with('Base')
  });

  if $unit {
    @files .= grep({ .contains($unit) });
    die "Could not find '{ $unit }' in Actions'" unless @files;
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
