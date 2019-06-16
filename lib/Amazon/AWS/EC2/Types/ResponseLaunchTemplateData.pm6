use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;

use Amazon::AWS::EC2::Types::CreditSpecification;
use Amazon::AWS::EC2::Types::ElasticGpuSpecificationResponse;
use Amazon::AWS::EC2::Types::LaunchTemplateBlockDeviceMapping;
use Amazon::AWS::EC2::Types::LaunchTemplateCapacityReservationSpecificationResponse;
use Amazon::AWS::EC2::Types::LaunchTemplateCpuOptions;
use Amazon::AWS::EC2::Types::LaunchTemplateElasticInferenceAcceleratorResponse;
use Amazon::AWS::EC2::Types::LaunchTemplateHibernationOptions;
use Amazon::AWS::EC2::Types::LaunchTemplateIamInstanceProfileSpecification;
use Amazon::AWS::EC2::Types::LaunchTemplateInstanceMarketOptions;
use Amazon::AWS::EC2::Types::LaunchTemplateInstanceNetworkInterfaceSpecification;
use Amazon::AWS::EC2::Types::LaunchTemplateLicenseConfiguration;
use Amazon::AWS::EC2::Types::LaunchTemplatePlacement;
use Amazon::AWS::EC2::Types::LaunchTemplateTagSpecification;
use Amazon::AWS::EC2::Types::LaunchTemplatesMonitoring;

class Amazon::AWS::EC2::Types::ResponseLaunchTemplateData is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has LaunchTemplateBlockDeviceMapping                          @.blockDeviceMappings                                                                    is xml-skip-null    is xml-container('blockDeviceMappingSet')             is rw;
  has LaunchTemplateCapacityReservationSpecificationResponse    $.capacityReservationSpecification     is xml-element(              :over-ride)          is xml-skip-null                                                          is rw;
  has LaunchTemplateCpuOptions                                  $.cpuOptions                           is xml-element(              :over-ride)          is xml-skip-null                                                          is rw;
  has CreditSpecification                                       $.creditSpecification                  is xml-element(              :over-ride)          is xml-skip-null                                                          is rw;
  has Bool                                                      $.disableApiTermination                is xml-element                                    is xml-skip-null                                                          is rw;
  has Bool                                                      $.ebsOptimized                         is xml-element                                    is xml-skip-null                                                          is rw;
  has ElasticGpuSpecificationResponse                           @.elasticGpuSpecifications                                                               is xml-skip-null    is xml-container('elasticGpuSpecificationSet')        is rw;
  has LaunchTemplateElasticInferenceAcceleratorResponse         @.elasticInferenceAccelerators         is xml-element('item',       :over-ride)          is xml-skip-null    is xml-container('elasticInferenceAcceleratorSet')    is rw;
  has LaunchTemplateHibernationOptions                          $.hibernationOptions                   is xml-element(              :over-ride)          is xml-skip-null                                                          is rw;
  has LaunchTemplateIamInstanceProfileSpecification             $.iamInstanceProfile                   is xml-element(              :over-ride)          is xml-skip-null                                                          is rw;
  has Str                                                       $.imageId                              is xml-element                                    is xml-skip-null                                                          is rw;
  has Str                                                       $.instanceInitiatedShutdownBehavior    is xml-element                                    is xml-skip-null                                                          is rw;   #=  stop | terminate
  has LaunchTemplateInstanceMarketOptions                       $.instanceMarketOptions                is xml-element(              :over-ride)          is xml-skip-null                                                          is rw;
  has Str                                                       $.instanceType                         is xml-element                                    is xml-skip-null                                                          is rw;   #= sub:Amazon::AWS::EC2::validInstanceTypes::checkInstanceType
  has Str                                                       $.kernelId                             is xml-element                                    is xml-skip-null                                                          is rw;
  has Str                                                       $.keyName                              is xml-element                                    is xml-skip-null                                                          is rw;
  has LaunchTemplateLicenseConfiguration                        @.licenses                             is xml-element('item',       :over-ride)          is xml-skip-null    is xml-container('licenseSpecificationSet')           is rw;
  has LaunchTemplatesMonitoring                                 $.monitoring                           is xml-element('monitoring', :over-ride)          is xml-skip-null                                                          is rw;
  has LaunchTemplateInstanceNetworkInterfaceSpecification       @.networkInterfaces                                                                      is xml-skip-null    is xml-container('networkInterfaceSet')               is rw;
  has LaunchTemplatePlacement                                   $.placement                            is xml-element(              :over-ride)          is xml-skip-null                                                          is rw;
  has Str                                                       $.ramDiskId                            is xml-element                                    is xml-skip-null                                                          is rw;
  has Str                                                       @.securityGroupIds                     is xml-element('item',       :over-ride)          is xml-skip-null    is xml-container('securityGroupSet')                  is rw;
  has Str                                                       @.securityGroups                       is xml-element('item',       :over-ride)          is xml-skip-null    is xml-container('securityGroupIdSet')                is rw;
  has LaunchTemplateTagSpecification                            @.tagSpecifications                    is xml-element('item',       :over-ride)          is xml-skip-null    is xml-container('tagSpecificationSet')               is rw;
  has Str                                                       $.userData                             is xml-element                                    is xml-skip-null                                                          is rw;
}
