use v6.d;

use Test;

use Amazon::AWS::EC2::Tests::TestTemplate;

unit package Amazon::AWS::EC2::Tests::DescribeAccountAttributes;

our sub runTests {
  
  subtest 'Testing with all attributes' => sub {
    my @attributeNames = $action.getAccountAttributeNames;
    @attributeNames.unshift: Nil;
    
    plan @attributeNames.elems * actionResponseTests;
    for @attributeNames {
      # @attributeNames has Nil prepended so as to test WITHOUT the 
      # AttributeNames parameter. So the $fixup value must be conditional
      my $fixup;
      $fixup = -> $o { $o.AttributeNames = $_.Array } if .defined;
      runTestCore(
        $?PACKAGE,
        $fixup,
        :!plan
      );
    }
  }
  
}
