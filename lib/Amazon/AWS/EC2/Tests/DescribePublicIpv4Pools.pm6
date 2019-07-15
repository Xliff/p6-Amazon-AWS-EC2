use v6.d;

use Amazon::AWS::EC2::Tests::TestTemplate;

use Amazon::AWS::EC2::Action::DescribePublicIpv4Pools;
use Amazon::AWS::EC2::Response::DescribePublicIpv4PoolsResponse;

unit package Amazon::AWS::EC2::Tests::DescribePublicIpv4Pools;

our sub runTests {
  runTestCore($?PACKAGE);
}
