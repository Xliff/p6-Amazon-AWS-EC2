use v6.d;

use Test;

use Amazon::AWS::EC2::Tests::TestTemplate;

unit package Amazon::AWS::EC2::Tests::DescribeAccountAttributes;

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
  }
  
  subtest 'Testing with all attributes' => sub {
    my @attributeNames = $action.getAccountAttributeNames;
    @attributeNames.unshift: Nil;
    
    plan @attributeNames.elems * actionResponseTests;
    for @attributeNames {
      # @attributeNames has Nil prepended so as to test WITHOUT the 
      # AttributeNames parameter. So the $fixup value must be conditional
      my $fixup;
      $fixup = -> $o { $o.AttributeNames = $_.Array } if .defined;
      runActionResponseTests(
        $action, 
        $response, 
        $fixup,
        :!plan
      );
    }
  }
}
