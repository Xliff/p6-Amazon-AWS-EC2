use v6.d;

role Amazon::AWS::Roles::Eqv {
  
  method eqv($b) {
    return False unless self.defined == $b.defined;
    return False unless self.WHAT =:= $b.WHAT; 
  
    for self.^attributes Z $b.^attributes -> ($x, $y) {
      my $attr = $x.name.substr(2);
      return False unless self."$attr"().defined == $b."$attr"().defined;
      if self."$attr"().defined {
        if self."$attr"() ~~ Amazon::AWS::Roles::Eqv {
          return False unless self."$attr"().eqv( $b."$attr"() )
        } else {
          return False unless self."$attr"() eqv $b."$attr"();
        }
      }
    }
    True;
  }
  
}
