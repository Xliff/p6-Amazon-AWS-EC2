use v6.d;

use Test;

use Amazon::AWS::EC2::Tests::TestTemplate;

unit package Amazon::AWS::EC2::Tests::DescribeTags;

our sub runTests {
  
  subtest 'Testing with all attributes' => sub {
    runTestCore($?PACKAGE); 
  }
  
}
