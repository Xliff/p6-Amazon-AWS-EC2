use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;

use Amazon::AWS::EC2::Types::ScheduledInstancesBlockDeviceMapping;
use Amazon::AWS::EC2::Types::ScheduledInstancesIamInstanceProfile;
use Amazon::AWS::EC2::Types::ScheduledInstancesMonitoring;
use Amazon::AWS::EC2::Types::ScheduledInstancesNetworkInterface;
use Amazon::AWS::EC2::Types::ScheduledInstancesPlacement;

class Amazon::AWS::EC2::Types::ScheduledInstancesLaunchSpecification is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has ScheduledInstancesBlockDeviceMapping    @.BlockDeviceMappings                                  is xml-skip-null    is xml-container('BlockDeviceMappings')      is rw;
  has Bool                                    $.EbsOptimized           is xml-element                is xml-skip-null                                                 is rw;
  has ScheduledInstancesIamInstanceProfile    $.IamInstanceProfile     is xml-element(:over-ride)    is xml-skip-null                                                 is rw;
  has Str                                     $.ImageId                is xml-element                is xml-skip-null                                                 is rw;
  has Str                                     $.InstanceType           is xml-element                is xml-skip-null                                                 is rw;
  has Str                                     $.KernelId               is xml-element                is xml-skip-null                                                 is rw;
  has Str                                     $.KeyName                is xml-element                is xml-skip-null                                                 is rw;
  has ScheduledInstancesMonitoring            $.Monitoring             is xml-element(:over-ride)    is xml-skip-null                                                 is rw;
  has ScheduledInstancesNetworkInterface      @.NetworkInterfaces                                    is xml-skip-null    is xml-container('NetworkInterfaces')        is rw;
  has ScheduledInstancesPlacement             $.Placement              is xml-element(:over-ride)    is xml-skip-null                                                 is rw;
  has Str                                     $.RamdiskId              is xml-element                is xml-skip-null                                                 is rw;
  has Str                                     @.SecurityGroupIds       is xml-element('item')        is xml-skip-null    is xml-container('SecurityGroupIds')         is rw;
  has Str                                     $.SubnetId               is xml-element                is xml-skip-null                                                 is rw;
  has Str                                     $.UserData               is xml-element                is xml-skip-null                                                 is rw;
}
