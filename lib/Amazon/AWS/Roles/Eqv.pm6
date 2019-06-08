use v6.d;

role Amazon::AWS::Roles::Eqv {

  method eqv($b) {
    unless self.defined == $b.defined {
      say '»»»» DEFINED';
      return False;
    }
    unless self.WHAT =:= $b.WHAT {
      say '»»»» WHAT';
      return False;
    }

    for self.^attributes Z $b.^attributes -> ($x, $y) {
      my $attr = $x.name.substr(2);
      unless self."$attr"().defined == $b."$attr"().defined {
        say "»»»» ATTR DEF - $attr";
        return False;
      }
      if self."$attr"().defined {
        if self."$attr"() ~~ Amazon::AWS::Roles::Eqv {
          unless self."$attr"().eqv( $b."$attr"() ) {
            say "»»»» EQV M -- {$b.^name}.{$attr}";
            return False
          }
        } else {
          unless self."$attr"() eqv $b."$attr"() {
            say "»»»» EQV P -- {$b.^name}.{$attr}";
            say "A: { self."$attr"() }";
            say "B: { $b."$attr"() }";
            return False
          }
        }
      }
    }
    True;
  }

}
