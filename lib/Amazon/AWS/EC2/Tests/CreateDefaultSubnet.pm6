use v6.d;

use Test;

use Amazon::AWS::EC2::Tests::TestTemplate;

use Amazon::AWS::EC2::Action::DescribeAvailabilityZones;

unit package Amazon::AWS::EC2::Tests::CreateDefaultSubnet;

our sub runTests is export {
  my @availZones = DescribeAvailabilityZones.new
                                            .run
                                            .availability-zones
                                            .map( *.zoneName );
  my $zone = @availZones.pick;
  
  diag "Creating in zone: $zone";
  
  my $ro = runTestCore(
    $?PACKAGE, 
    -> $o { $o.AvailabilityZone = $zone } 
  );
    
  diag $ro.gist;
}
