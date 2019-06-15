use v6.d;

use Test;

# If this gets any larger, it will need a better name.
role Amazon::AWS::Roles::Eqv {

  multi method is-empty {
    for self.^attributes {
      return False if not self.is-empty( self."{ .name.substr(2) }"() );
    }
    True;
  }

  multi method is-empty ($v) {
    return True if not $v.defined;
    given $v {
      when Str                     { .chars.not  }
      when Int                     { 0           }
      when Bool                    { False       }
      #when Amazon::AWS::Roles::Eqv { $v.is-empty }

      default {
        die "Cannot determine the emptiness of a { .^name } object."
      }
    }
  }

  method testval($a, $b) {
    do given $a {
      when .defined.not            { $b.is-empty ?? True !! False }
      when Amazon::AWS::Roles::Eqv { .eqv($b)    ?? True !! False }

      when Positional              { return False unless $_.elems == $b.elems;
                                     for $_.Array Z $b.Array -> ($x, $y) {
                                       say $x.gist;
                                       say $y.gist;
                                       return False
                                         unless self.testval($x, $y);
                                     }
                                     True }

      default                      { $_ eqv $b }
    }
  }

  method eqv($b) {
    #return False unless self.defined == $b.is-empty;
    return False unless self.WHAT =:= $b.WHAT;

    for self.^attributes Z $b.^attributes -> ($x, $y) {
      my $attr = $x.name.substr(2);
      diag $attr;
      my ($aval, $bval) = ( self."$attr"(), $b."$attr"() );
      #return False unless $aval.defined == $bval.is-empty;
      return False unless self.testval($aval, $bval);
    }
    True;
  }

}
