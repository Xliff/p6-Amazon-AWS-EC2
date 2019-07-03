use v6.d;

use Test;

use Amazon::AWS::EC2::Tests::TestTemplate;

unit package Amazon::AWS::EC2::Tests::DescribeVpcAttribute;

my @vpcIds;

our sub runTests {
  my $c = $?FILE.split('::')[*-1].substr(0, * - 1);
  # YYY- Determine why quietly is needed, here!
  my ($action, $response);
  quietly {
    $action := do {
      if not %classes{$c}:exists {
        %classes{$c} := try require ::("Amazon::AWS::EC2::Action::{ $c }");
      }
      %classes{$c}
    };
    $response := do {
      if not %classes{"{$c}Response"}:exists {
        %classes{"{$c}Response"} := 
          try require ::("Amazon::AWS::EC2::Response::{ $c }Response");
      }
      %classes{"{$c}Response"};
    };
    
    # Load extra classes LAST!
    %classes<DescribeSubnets> = 
      try require ::('Amazon::AWS::EC2::Action::DescribeSubnets');
  }
  
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
      my $fixup = -> $o { 
        $o.VpcId     = $vpcId;
        $o.Attribute = $_;
      };
      my $ro = runActionResponseTests(
        $action, 
        $response, 
        $fixup,
        :!plan
      );
    }
  }
}
