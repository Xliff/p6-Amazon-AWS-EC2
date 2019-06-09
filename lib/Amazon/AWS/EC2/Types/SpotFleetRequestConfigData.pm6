use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;

use Amazon::AWS::EC2::Types::LaunchTemplateConfig;
use Amazon::AWS::EC2::Types::LoadBalancersConfig;
use Amazon::AWS::EC2::Types::SpotFleetLaunchSpecification;

class Amazon::AWS::EC2::Types::SpotFleetRequestConfigData is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Str                             $.AllocationStrategy                  is xml-element                                                   is rw;   #=  lowestPrice | diversified
  has Str                             $.allocationStrategy                  is xml-element                                                   is rw;   #=  lowestPrice | diversified
  has Str                             $.ClientToken                         is xml-element                                                   is rw;
  has Str                             $.clientToken                         is xml-element                                                   is rw;
  has Str                             $.ExcessCapacityTerminationPolicy     is xml-element                                                   is rw;   #=  noTermination | default
  has Str                             $.excessCapacityTerminationPolicy     is xml-element                                                   is rw;   #=  noTermination | default
  has Num                             $.FulfilledCapacity                   is xml-element                                                   is rw;
  has Num                             $.fulfilledCapacity                   is xml-element                                                   is rw;
  has Str                             $.IamFleetRole                        is xml-element                                                   is rw;
  has Str                             $.iamFleetRole                        is xml-element                                                   is rw;
  has Str                             $.InstanceInterruptionBehavior        is xml-element                                                   is rw;   #=  hibernate | stop | terminate
  has Str                             $.instanceInterruptionBehavior        is xml-element                                                   is rw;   #=  hibernate | stop | terminate
  has Int                             $.InstancePoolsToUseCount             is xml-element                                                   is rw;
  has Int                             $.instancePoolsToUseCount             is xml-element                                                   is rw;
  has SpotFleetLaunchSpecification    @.LaunchSpecifications                is xml-element    is xml-container('LaunchSpecifications')       is rw;
  has SpotFleetLaunchSpecification    @.launchSpecifications                is xml-element    is xml-container('launchSpecifications')       is rw;
  has LaunchTemplateConfig            @.LaunchTemplateConfigs               is xml-element    is xml-container('LaunchTemplateConfigs')      is rw;
  has LaunchTemplateConfig            @.launchTemplateConfigs               is xml-element    is xml-container('launchTemplateConfigs')      is rw;
  has LoadBalancersConfig             $.LoadBalancersConfig                 is xml-element                                                   is rw;
  has LoadBalancersConfig             $.loadBalancersConfig                 is xml-element                                                   is rw;
  has Str                             $.OnDemandAllocationStrategy          is xml-element                                                   is rw;   #=  lowestPrice | prioritized
  has Str                             $.onDemandAllocationStrategy          is xml-element                                                   is rw;   #=  lowestPrice | prioritized
  has Num                             $.OnDemandFulfilledCapacity           is xml-element                                                   is rw;
  has Num                             $.onDemandFulfilledCapacity           is xml-element                                                   is rw;
  has Int                             $.OnDemandTargetCapacity              is xml-element                                                   is rw;
  has Int                             $.onDemandTargetCapacity              is xml-element                                                   is rw;
  has Bool                            $.ReplaceUnhealthyInstances           is xml-element                                                   is rw;
  has Bool                            $.replaceUnhealthyInstances           is xml-element                                                   is rw;
  has Str                             $.SpotPrice                           is xml-element                                                   is rw;
  has Str                             $.spotPrice                           is xml-element                                                   is rw;
  has Int                             $.TargetCapacity                      is xml-element                                                   is rw;
  has Int                             $.targetCapacity                      is xml-element                                                   is rw;
  has Bool                            $.TerminateInstancesWithExpiration    is xml-element                                                   is rw;
  has Bool                            $.terminateInstancesWithExpiration    is xml-element                                                   is rw;
  has Str                             $.Type                                is xml-element                                                   is rw;   #=  request | maintain | instant
  has Str                             $.type                                is xml-element                                                   is rw;   #=  request | maintain | instant
  has Str                             $.ValidFrom                           is xml-element                                                   is rw;
  has Str                             $.validFrom                           is xml-element                                                   is rw;
  has Str                             $.ValidUntil                          is xml-element                                                   is rw;
  has Str                             $.validUntil                          is xml-element                                                   is rw;
}
