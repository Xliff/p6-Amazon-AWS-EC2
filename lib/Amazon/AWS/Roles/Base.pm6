use v6.d;

role Amazon::AWS::Roles::Base {

  method pairs {
    my @p;
    for self.^attributes.map( *.name.substr(2) ).sort {
      @p.push: Pair.new($_, self."$_"()) if self."$_"().defined;
    }
    @p;
  }

}
