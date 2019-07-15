use v6.d;

use Amazon::AWS::EC2::Tests::TestTemplate;

unit package Amazon::AWS::EC2::Tests::DescribeVpcs;

our sub runTests {
  runTestCore($?PACKAGE);
}
