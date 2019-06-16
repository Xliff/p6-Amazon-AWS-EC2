use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;

use Amazon::AWS::EC2::Types::CreditSpecificationRequest;
use Amazon::AWS::EC2::Types::ElasticGpuSpecification;
use Amazon::AWS::EC2::Types::LaunchTemplateBlockDeviceMappingRequest;
use Amazon::AWS::EC2::Types::LaunchTemplateCapacityReservationSpecificationRequest;
use Amazon::AWS::EC2::Types::LaunchTemplateCpuOptionsRequest;
use Amazon::AWS::EC2::Types::LaunchTemplateElasticInferenceAccelerator;
use Amazon::AWS::EC2::Types::LaunchTemplateHibernationOptionsRequest;
use Amazon::AWS::EC2::Types::LaunchTemplateIamInstanceProfileSpecificationRequest;
use Amazon::AWS::EC2::Types::LaunchTemplateInstanceMarketOptionsRequest;
use Amazon::AWS::EC2::Types::LaunchTemplateInstanceNetworkInterfaceSpecificationRequest;
use Amazon::AWS::EC2::Types::LaunchTemplateLicenseConfigurationRequest;
use Amazon::AWS::EC2::Types::LaunchTemplatePlacementRequest;
use Amazon::AWS::EC2::Types::LaunchTemplateTagSpecificationRequest;
use Amazon::AWS::EC2::Types::LaunchTemplatesMonitoringRequest;

class Amazon::AWS::EC2::Types::RequestLaunchTemplateData is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has LaunchTemplateBlockDeviceMappingRequest                       @.BlockDeviceMappings                                                                    is xml-skip-null    is xml-container('BlockDeviceMappingSet')             is rw;
  has LaunchTemplateCapacityReservationSpecificationRequest         $.CapacityReservationSpecification     is xml-element(        :over-ride)                is xml-skip-null                                                          is rw;
  has LaunchTemplateCpuOptionsRequest                               $.CpuOptions                           is xml-element(        :over-ride)                is xml-skip-null                                                          is rw;
  has CreditSpecificationRequest                                    $.CreditSpecification                  is xml-element(        :over-ride)                is xml-skip-null                                                          is rw;
  has Bool                                                          $.DisableApiTermination                is xml-element                                    is xml-skip-null                                                          is rw;
  has Bool                                                          $.EbsOptimized                         is xml-element                                    is xml-skip-null                                                          is rw;
  has ElasticGpuSpecification                                       @.ElasticGpuSpecifications                                                               is xml-skip-null    is xml-container('ElasticGpuSpecificationSet')        is rw;
  has LaunchTemplateElasticInferenceAccelerator                     @.ElasticInferenceAccelerators         is xml-element('item',  :over-ride)               is xml-skip-null    is xml-container('ElasticInferenceAcceleratorSet')    is rw;
  has LaunchTemplateHibernationOptionsRequest                       $.HibernationOptions                   is xml-element('item',  :over-ride)               is xml-skip-null                                                          is rw;
  has LaunchTemplateIamInstanceProfileSpecificationRequest          $.IamInstanceProfile                   is xml-element(         :over-ride)               is xml-skip-null                                                          is rw;
  has Str                                                           $.ImageId                              is xml-element                                    is xml-skip-null                                                          is rw;
  has Str                                                           $.InstanceInitiatedShutdownBehavior    is xml-element                                    is xml-skip-null                                                          is rw;   #=  stop | terminate
  has LaunchTemplateInstanceMarketOptionsRequest                    $.InstanceMarketOptions                is xml-element(         :over-ride)               is xml-skip-null                                                          is rw;
  has Str                                                           $.InstanceType                         is xml-element                                    is xml-skip-null                                                          is rw;   #= sub:Amazon::AWS::EC2::validInstanceTypes::checkInstanceType
  has Str                                                           $.KernelId                             is xml-element                                    is xml-skip-null                                                          is rw;
  has Str                                                           $.KeyName                              is xml-element                                    is xml-skip-null                                                          is rw;
  has LaunchTemplateLicenseConfigurationRequest                     @.LicenseSpecifications                is xml-element(        :over-ride)                is xml-skip-null    is xml-container('LicenseSpecificationSet')           is rw;
  has LaunchTemplatesMonitoringRequest                              $.Monitoring                           is xml-element(        :over-ride)                is xml-skip-null                                                          is rw;
  has LaunchTemplateInstanceNetworkInterfaceSpecificationRequest    @.NetworkInterfaces                                                                      is xml-skip-null    is xml-container('NetworkInterfaceSet')               is rw;
  has LaunchTemplatePlacementRequest                                $.Placement                            is xml-element(        :over-ride)                is xml-skip-null                                                          is rw;
  has Str                                                           $.RamDiskId                            is xml-element                                    is xml-skip-null                                                          is rw;
  has Str                                                           @.SecurityGroups                       is xml-element('item', :over-ride)                is xml-skip-null    is xml-container('SecurityGroupSet')                  is rw;
  has Str                                                           @.SecurityGroupIds                     is xml-element('item', :over-ride)                is xml-skip-null    is xml-container('SecurityGroupIdSet')                is rw;
  has LaunchTemplateTagSpecificationRequest                         @.TagSpecifications                    is xml-element('item', :over-ride)                is xml-skip-null    is xml-container('TagSpecificationSet')               is rw;
  has Str                                                           $.UserData                             is xml-element                                    is xml-skip-null                                                          is rw;
}
