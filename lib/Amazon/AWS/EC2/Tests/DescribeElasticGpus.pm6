use v6.d;

use Amazon::AWS::EC2::Tests::TestTemplate;

unit package Amazon::AWS::EC2::Tests::DescribeElasticGpus;

our sub runTests is export {
  runTestCore($?PACKAGE);
}
