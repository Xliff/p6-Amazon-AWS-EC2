use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;

use Amazon::AWS::EC2::Types::BlockDeviceMapping;
use Amazon::AWS::EC2::Types::IamInstanceProfileSpecification;
use Amazon::AWS::EC2::Types::InstanceNetworkInterfaceSpecification;
use Amazon::AWS::EC2::Types::RunInstancesMonitoringEnabled;
use Amazon::AWS::EC2::Types::SpotPlacement;

class Amazon::AWS::EC2::Types::RequestSpotLaunchSpecification is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Str                                      $.AddressingType         is xml-element                        is xml-skip-null                                                 is rw;
  has BlockDeviceMapping                       @.BlockDeviceMappings    is xml-element('item', :over-ride)    is xml-skip-null    is xml-container('BlockDeviceMappingSet')    is rw;
  has Bool                                     $.EbsOptimized           is xml-element                        is xml-skip-null                                                 is rw;
  has IamInstanceProfileSpecification          $.IamInstanceProfile                                           is xml-skip-null                                                 is rw;
  has Str                                      $.ImageId                is xml-element                        is xml-skip-null                                                 is rw;
  has Str                                      $.InstanceType           is xml-element                        is xml-skip-null                                                 is rw;   #= sub:Amazon::AWS::EC2::validInstanceTypes::checkInstanceType
  has Str                                      $.KernelId               is xml-element                        is xml-skip-null                                                 is rw;
  has Str                                      $.KeyName                is xml-element                        is xml-skip-null                                                 is rw;
  has RunInstancesMonitoringEnabled            $.Monitoring                                                   is xml-skip-null                                                 is rw;
  has InstanceNetworkInterfaceSpecification    @.NetworkInterfaces                                            is xml-skip-null    is xml-container('NetworkInterfaceSet')      is rw;
  has SpotPlacement                            $.Placement                                                    is xml-skip-null                                                 is rw;
  has Str                                      $.RamdiskId              is xml-element                        is xml-skip-null                                                 is rw;
  has Str                                      @.SecurityGroups         is xml-element('item')                is xml-skip-null    is xml-container('SecurityGroupSet')         is rw;
  has Str                                      @.SecurityGroupIds       is xml-element('item')                is xml-skip-null    is xml-container('SecurityGroupIdSet')       is rw;
  has Str                                      $.SubnetId               is xml-element                        is xml-skip-null                                                 is rw;
  has Str                                      $.UserData               is xml-element                        is xml-skip-null                                                 is rw;
}
