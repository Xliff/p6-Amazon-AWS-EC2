use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;

use Amazon::AWS::EC2::Types::DescribeFleetError;
use Amazon::AWS::EC2::Types::DescribeFleetsInstances;
use Amazon::AWS::EC2::Types::FleetLaunchTemplateConfig;
use Amazon::AWS::EC2::Types::OnDemandOptions;
use Amazon::AWS::EC2::Types::SpotOptions;
use Amazon::AWS::EC2::Types::Tag;
use Amazon::AWS::EC2::Types::TargetCapacitySpecification;

class Amazon::AWS::EC2::Types::FleetData is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Str                            $.activityStatus                      is xml-element                                                   is rw;   #=  error | pending-fulfillment | pending-termination | fulfilled
  has Str                            $.clientToken                         is xml-element                                                   is rw;
  has Str                            $.createTime                          is xml-element                                                   is rw;
  has DescribeFleetError             @.errors                              is xml-element    is xml-container('errorSet')                   is rw;
  has Str                            $.excessCapacityTerminationPolicy     is xml-element                                                   is rw;   #=  no-termination | termination
  has Str                            $.fleetId                             is xml-element                                                   is rw;
  has DescribeFleetsInstances        @.fleetInstances                      is xml-element    is xml-container('fleetInstanceSet')           is rw;
  has Str                            $.fleetState                          is xml-element                                                   is rw;   #=  submitted | active | deleted | failed | deleted-running | deleted-terminating | modifying
  has Num                            $.fulfilledCapacity                   is xml-element                                                   is rw;
  has Num                            $.fulfilledOnDemandCapacity           is xml-element                                                   is rw;
  has FleetLaunchTemplateConfig      @.launchTemplateConfigs               is xml-element    is xml-container('launchTemplateConfigs')      is rw;
  has OnDemandOptions                $.onDemandOptions                     is xml-element                                                   is rw;
  has Bool                           $.replaceUnhealthyInstances           is xml-element                                                   is rw;
  has SpotOptions                    $.spotOptions                         is xml-element                                                   is rw;
  has Tag                            @.tags                                is xml-element    is xml-container('tagSet')                     is rw;
  has TargetCapacitySpecification    $.targetCapacitySpecification         is xml-element                                                   is rw;
  has Bool                           $.terminateInstancesWithExpiration    is xml-element                                                   is rw;
  has Str                            $.type                                is xml-element                                                   is rw;   #=  request | maintain | instant
  has Str                            $.validFrom                           is xml-element                                                   is rw;
  has Str                            $.validUntil                          is xml-element                                                   is rw;
}
