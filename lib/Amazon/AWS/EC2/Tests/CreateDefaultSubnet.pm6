use v6.d;

use Test;

use Amazon::AWS::EC2::Tests::TestTemplate;

use Amazon::AWS::EC2::Action::DescribeAvailabilityZones;

unit package Amazon::AWS::EC2::Tests::CreateDefaultSubnet;

our sub runTests is export {
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
  
  my @availZones = DescribeAvailabilityZones.new
                                            .run
                                            .availability-zones
                                            .map( *.zoneName );
  my $zone = @availZones.pick;
  
  diag "Creating in zone: $zone";
  
  my $ro = runActionResponseTests(
    $action, 
    $response,
    -> $o { $o.AvailabilityZone = $zone } 
  );
  
  diag $ro.gist;
}
