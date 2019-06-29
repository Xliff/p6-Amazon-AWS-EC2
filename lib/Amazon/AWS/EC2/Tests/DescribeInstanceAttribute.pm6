use v6.d;

use Test;

use Amazon::AWS::EC2::Tests::TestTemplate;

unit package Amazon::AWS::EC2::Tests::DescribeInstanceAttribute;

my @instanceIds;

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
    %classes<DescribeInstances> = 
      try require ::('Amazon::AWS::EC2::Action::DescribeInstances');
  }
  
  subtest 'Testing with all attributes' => sub {
    my @attributes = $action.getAttributes;
    
    # Get random instance attribute from instamces.
    # Should have some mechanism where we can get maxResults passed in
    # from the command line using the naked value as a default.
    unless @instanceIds {
      @instanceIds = %classes<DescribeInstances>.new(maxResults => 5)
                                                .run
                                                .reservations
                                                .map( 
                                                  *.instances.map( *.instanceId )
                                                ).flat;
    }
    my $instanceId = @instanceIds.pick;
                                        
    diag "Using instanceID: { $instanceId }"; 
    plan @attributes.elems * actionResponseTests;
    for @attributes {
      my $fixup = -> $o { 
        $o.InstanceId = $instanceId;
        $o.Attribute = $_;
      };
      runActionResponseTests(
        $action, 
        $response, 
        $fixup,
        :!plan
      );
    }
  }
}
