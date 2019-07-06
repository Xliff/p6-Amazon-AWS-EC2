use v6.d;

use Test;

use Amazon::AWS::EC2::Filters::DescribeSecurityGroupsFilter;

use Amazon::AWS::EC2::Tests::TestTemplate;

unit package Amazon::AWS::EC2::Tests::DescribeSecurityGroups;

constant IpPermission :=
  Amazon::AWS::EC2::Filters::DescribeSecurityGroupsFilter::IpPermission;

our sub runTests {
  my $c = $?FILE.split('::')[*-1].substr(0, * - 1);
  # YYY- Determine why quietly is needed, here!
  my ($action, $response);
  
  say "U: { $c // 'WTF?' }";
  
  quietly {
    %classes{$c} := 
      ( try require ::("Amazon::AWS::EC2::Action::{ $c }") )
        if not %classes{$c}:exists;
    $action := %classes{$c};
    %classes{"{$c}Response"} := 
      ( try require ::("Amazon::AWS::EC2::Response::{ $c }Response") )
        if not %classes{"{$c}Response"}:exists;
    %classes.gist.say;
    $response := %classes{"{$c}Response"};
  }
  
  my $ro = runActionResponseTests($action, $response);
  my $sgId = $ro.groups.map( *.groupId ).pick;
  
  diag "Using security group: { $sgId }";
  subtest "Testing all protocols" => {
    my @protocols = IpPermission.getProtocols;
    plan @protocols.elems ** 2 * actionResponseTests;
    for @protocols X @protocols -> ($xp, $yp) {
      diag "Testing protocol: { $xp } / { $yp }";
      
      runActionResponseTests(
        $action, 
        $response,
        -> $o { 
          $o.GroupId = $sgId.Array;
          
          my $f = DescribeSecurityGroupsFilter.new;
          $f.egress.protocol = $xp;
          $f.ip-permission.protocol = $yp;
          $o.Filter.push: $f;
        },
        :!plan
      );
    }
  }
}
