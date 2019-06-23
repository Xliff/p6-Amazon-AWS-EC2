use v6.d;

use Amazon::AWS::EC2::Tests::TestTemplate;

unit package Amazon::AWS::EC2::Tests::DescribeAccountAttributes;

our sub runTests {
  my $c = $?FILE.split('::')[*-1].substr(0, * - 1);
  # YYY- Determine why quietly is needed, here!
  my ($action, $response);
  quietly {
    $action := ( %classes{$c} := 
      try require ::("Amazon::AWS::EC2::Action::{ $c }") )
        if not %classes{$c}:exists;
    $response := ( %classes{"{$c}Response"} := 
      try require ::("Amazon::AWS::EC2::Response::{ $c }Response") )
        if not %classes{"{$c}Response"}:exists;
  }
  
  subtest 'Testing with all attributes' => sub {
    my @attributeNames = $action.getAccountAttributeNames;
    @attributeNames.unshift: Nil;
    
    plan @attributeNames.elems;
    for @attributeNames {
      # @attributeNames has Nil prepended so as to test WITHOUT the 
      # AttributeName parameter. So the $fixup value must be conditional
      my $fixup;
      $fixup = -> $o { $o.AttributeName = $_ } if .defined;
      runActionResponseTests(
        $action, 
        $response, 
        $fixup
      );
    }
  }
}
