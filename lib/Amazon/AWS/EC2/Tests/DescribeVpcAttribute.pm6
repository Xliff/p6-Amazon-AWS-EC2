use v6.d;

use Test;

use Amazon::AWS::EC2::Tests::TestTemplate;

unit package Amazon::AWS::EC2::Tests::DescribeVpcAttribute;

my @vpcIds;

our sub runTests {
  
  subtest 'Testing with all attributes' => sub {
    my @attributes = $action.getValidAttributes;
    
    # Get random instance attribute from instamces.
    # Should have some mechanism where we can get maxResults passed in
    # from the command line using the naked value as a default.
    unless @vpcIds {
      @vpcIds = %classes<DescribeSubnets>.new(maxResults => 5)
                                         .run
                                         .subnets
                                         .map( *.vpcId )
                                         .flat;
    }
    my $vpcId = @vpcIds.pick;
                                        
    diag "Using vpcID: { $vpcId }"; 
    plan @attributes.elems * actionResponseTests;
    for @attributes {
      my $ro = runActionResponseTests(
        $?PACKAGE,
        loadup => -> {
          # Load extra classes LAST!
          %classes<DescribeSubnets> = 
            try require ::('Amazon::AWS::EC2::Action::DescribeSubnets');
        },
        fixup => -> $o { 
          $o.VpcId     = $vpcId;
          $o.Attribute = $_;
        },
        :!plan
      );
    }
  }
  
}
