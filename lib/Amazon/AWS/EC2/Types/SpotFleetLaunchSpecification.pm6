use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;

use Amazon::AWS::EC2::Types::BlockDeviceMapping;
use Amazon::AWS::EC2::Types::GroupIdentifier;
use Amazon::AWS::EC2::Types::IamInstanceProfileSpecification;
use Amazon::AWS::EC2::Types::InstanceNetworkInterfaceSpecification;
use Amazon::AWS::EC2::Types::SpotFleetMonitoring;
use Amazon::AWS::EC2::Types::SpotFleetTagSpecification;
use Amazon::AWS::EC2::Types::SpotPlacement;

class Amazon::AWS::EC2::Types::SpotFleetLaunchSpecification is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Str                                      $.AddressingType         is xml-element                        is xml-skip-null                                                 is rw;
  has Str                                      $.addressingType         is xml-element                        is xml-skip-null                                                 is rw;
  has BlockDeviceMapping                       @.BlockDeviceMappings    is xml-element('item', :over-ride)    is xml-skip-null    is xml-container('BlockDeviceMappings')      is rw;
  has BlockDeviceMapping                       @.blockDeviceMapping     is xml-element('item', :over-ride)    is xml-skip-null    is xml-container('blockDeviceMapping')       is rw;
  has Bool                                     $.EbsOptimized           is xml-element                        is xml-skip-null                                                 is rw;
  has Bool                                     $.ebsOptimized           is xml-element                        is xml-skip-null                                                 is rw;
  has GroupIdentifier                          @.SecurityGroups         is xml-element('item', :over-ride)    is xml-skip-null    is xml-container('SecurityGroups')           is rw;
  has GroupIdentifier                          @.groups                 is xml-element('item', :over-ride)    is xml-skip-null    is xml-container('groupSet')                 is rw;
  has IamInstanceProfileSpecification          $.IamInstanceProfile     is xml-element(        :over-ride)    is xml-skip-null                                                 is rw;
  has IamInstanceProfileSpecification          $.iamInstanceProfile     is xml-element(        :over-ride)    is xml-skip-null                                                 is rw;
  has Str                                      $.ImageId                is xml-element                        is xml-skip-null                                                 is rw;
  has Str                                      $.imageId                is xml-element                        is xml-skip-null                                                 is rw;
  has Str                                      $.InstanceType           is xml-element                        is xml-skip-null                                                 is rw;   #=  check=Amazon::AWS::EC2::validInstanceTypes
  has Str                                      $.instanceType           is xml-element                        is xml-skip-null                                                 is rw;   #=  check=Amazon::AWS::EC2::validInstanceTypes
  has Str                                      $.KernelId               is xml-element                        is xml-skip-null                                                 is rw;
  has Str                                      $.kernelId               is xml-element                        is xml-skip-null                                                 is rw;
  has Str                                      $.KeyName                is xml-element                        is xml-skip-null                                                 is rw;
  has Str                                      $.keyName                is xml-element                        is xml-skip-null                                                 is rw;
  has SpotFleetMonitoring                      $.Monitoring             is xml-element(        :over-ride)    is xml-skip-null                                                 is rw;
  has SpotFleetMonitoring                      $.monitoring             is xml-element(        :over-ride)    is xml-skip-null                                                 is rw;
  has InstanceNetworkInterfaceSpecification    @.networkInterfaces                                            is xml-skip-null    is xml-container('networkInterfaceSet')      is rw;
  has InstanceNetworkInterfaceSpecification    @.NetworkInterfaces                                            is xml-skip-null    is xml-container('NetworkInterfaces')        is rw;
  has SpotPlacement                            $.Placement              is xml-element                        is xml-skip-null                                                 is rw;
  has SpotPlacement                            $.placement              is xml-element                        is xml-skip-null                                                 is rw;
  has Str                                      $.RamdiskId              is xml-element                        is xml-skip-null                                                 is rw;
  has Str                                      $.ramdiskId              is xml-element                        is xml-skip-null                                                 is rw;
  has Str                                      $.SpotPrice              is xml-element                        is xml-skip-null                                                 is rw;
  has Str                                      $.spotPrice              is xml-element                        is xml-skip-null                                                 is rw;
  has Str                                      $.SubnetId               is xml-element                        is xml-skip-null                                                 is rw;
  has Str                                      $.subnetId               is xml-element                        is xml-skip-null                                                 is rw;
  has SpotFleetTagSpecification                @.TagSpecifications                                            is xml-skip-null    is xml-container('TagSpecifications')        is rw;
  has SpotFleetTagSpecification                @.tagSpecifications                                            is xml-skip-null    is xml-container('tagSpecificationSet')      is rw;
  has Str                                      $.UserData               is xml-element                        is xml-skip-null                                                 is rw;
  has Str                                      $.userData               is xml-element                        is xml-skip-null                                                 is rw;
  has Num                                      $.WeightedCapacity       is xml-element                        is xml-skip-null                                                 is rw;
  has Num                                      $.weightedCapacity       is xml-element                        is xml-skip-null                                                 is rw;
}
