use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;

use Amazon::AWS::EC2::Types::BlockDeviceMapping;
use Amazon::AWS::EC2::Types::GroupIdentifier;
use Amazon::AWS::EC2::Types::IamInstanceProfileSpecification;
use Amazon::AWS::EC2::Types::InstanceNetworkInterfaceSpecification;
use Amazon::AWS::EC2::Types::RunInstancesMonitoringEnabled;
use Amazon::AWS::EC2::Types::SpotPlacement;

class Amazon::AWS::EC2::Types::LaunchSpecification is export
  does XML::Class
{
  also is Amazon::AWS::EC2::Types::Base;

  has Str                                      $.addressingType        is xml-element                        is xml-skip-null                                                 is rw;
  has BlockDeviceMapping                       @.blockDeviceMapping    is xml-element('item', :over-ride)    is xml-skip-null    is xml-container('blockDeviceMapping')       is rw;
  has Bool                                     $.ebsOptimized          is xml-element                        is xml-skip-null                                                 is rw;
  has GroupIdentifier                          @.groups                is xml-element('item', :over-ride)    is xml-skip-null    is xml-container('groupSet')                 is rw;
  has IamInstanceProfileSpecification          $.iamInstanceProfile    is xml-element(        :over-ride)    is xml-skip-null                                                 is rw;
  has Str                                      $.imageId               is xml-element                        is xml-skip-null                                                 is rw;
  has Str                                      $.instanceType          is xml-element                        is xml-skip-null                                                 is rw;   #= sub:Amazon::AWS::EC2::validInstanceTypes::checkInstanceType
  has Str                                      $.kernelId              is xml-element                        is xml-skip-null                                                 is rw;
  has Str                                      $.keyName               is xml-element                        is xml-skip-null                                                 is rw;
  has RunInstancesMonitoringEnabled            $.monitoring            is xml-element(        :over-ride)    is xml-skip-null                                                 is rw;
  has InstanceNetworkInterfaceSpecification    @.networkInterfaces                                           is xml-skip-null    is xml-container('networkInterfaceSet')      is rw;
  has SpotPlacement                            $.placement             is xml-element(        :over-ride)    is xml-skip-null                                                 is rw;
  has Str                                      $.ramdiskId             is xml-element                        is xml-skip-null                                                 is rw;
  has Str                                      $.subnetId              is xml-element                        is xml-skip-null                                                 is rw;
  has Str                                      $.userData              is xml-element                        is xml-skip-null                                                 is rw;
}
