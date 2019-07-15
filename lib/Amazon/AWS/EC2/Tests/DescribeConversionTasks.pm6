use v6.d;

use Test;

use Amazon::AWS::EC2::Tests::TestTemplate;

unit package Amazon::AWS::EC2::Tests::DescribeConversionTasks;

our sub runTests {
  runTestCore($?PACKAGE);
  
}
