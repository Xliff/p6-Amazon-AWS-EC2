use v6.d;

role Amazon::AWS::Request {

  method pairs {
    my @dv;
    for self.^attributes.map( *.name.substr(2) ) {
      @dv.push: Pair.new($_, self.$_()) if self.$_().defined;
    }
    @dv;
  }
  
}
