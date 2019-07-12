use v6.d;

use Amazon::AWS::EC2::Tests::TestTemplate;

use Amazon::AWS::EC2::Action::DescribeSecurityGroups;
use Amazon::AWS::EC2::Response::DescribeSecurityGroupsResponse;

unit package Amazon::AWS::EC2::Tests::DescribeSecurityGroups;

our sub runTests {
  my $c = $?FILE.split('::')[*-1].substr(0, * - 1);
  # YYY- Determine why quietly is needed, here!
  my ($action, $response);
  quietly {
    # For some reason, these objects do not like dynamic loading.
    $response := DescribeSecurityGroupsResponse;
    $action   := DescribeSecurityGroups;
  }
  
  runActionResponseTests($action, $response);
}
