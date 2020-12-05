use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;

use Amazon::AWS::EC2::Types::EbsInfo;
use Amazon::AWS::EC2::Types::FpgaInfo;
use Amazon::AWS::EC2::Types::GpuInfo;
use Amazon::AWS::EC2::Types::InferenceAcceleratorInfo;
use Amazon::AWS::EC2::Types::InstanceStorageInfo;
use Amazon::AWS::EC2::Types::MemoryInfo;
use Amazon::AWS::EC2::Types::NetworkInfo;
use Amazon::AWS::EC2::Types::PlacementGroupInfo;
use Amazon::AWS::EC2::Types::ProcessorInfo;
use Amazon::AWS::EC2::Types::VCpuInfo;

class Amazon::AWS::EC2::Types::InstanceTypeInfo is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Bool                        $.autoRecoverySupported            is xml-element                          is xml-skip-null                                                          is rw;
  has Bool                        $.bareMetal                        is xml-element                          is xml-skip-null                                                          is rw;
  has Bool                        $.burstablePerformanceSupported    is xml-element                          is xml-skip-null                                                          is rw;
  has Bool                        $.currentGeneration                is xml-element                          is xml-skip-null                                                          is rw;
  has Bool                        $.dedicatedHostsSupported          is xml-element                          is xml-skip-null                                                          is rw;
  has EbsInfo                     $.ebsInfo                          is xml-element(:over-ride)              is xml-skip-null                                                          is rw;
  has FpgaInfo                    $.fpgaInfo                         is xml-element(:over-ride)              is xml-skip-null                                                          is rw;
  has Bool                        $.freeTierEligible                 is xml-element                          is xml-skip-null                                                          is rw;
  has GpuInfo                     $.gpuInfo                          is xml-element(:over-ride)              is xml-skip-null                                                          is rw;
  has Bool                        $.hibernationSupported             is xml-element                          is xml-skip-null                                                          is rw;
  has Str                         $.hypervisor                       is xml-element(:over-ride)              is xml-skip-null                                                          is rw;   #=  nitro | xen
  has InferenceAcceleratorInfo    $.inferenceAcceleratorInfo         is xml-element(:over-ride)              is xml-skip-null                                                          is rw;
  has InstanceStorageInfo         $.instanceStorageInfo              is xml-element                          is xml-skip-null                                                          is rw;
  has Bool                        $.instanceStorageSupported         is xml-element                          is xml-skip-null                                                          is rw;
  has Str                         $.instanceType                     is xml-element                          is xml-skip-null                                                          is rw;   #= validation:Amazon::AWS::EC2::validInstanceTypes::checkInstanceType
  has MemoryInfo                  $.memoryInfo                       is xml-element(:over-ride)              is xml-skip-null                                                          is rw;
  has NetworkInfo                 $.networkInfo                      is xml-element(:over-ride)              is xml-skip-null                                                          is rw;
  has PlacementGroupInfo          $.placementGroupInfo               is xml-element(:over-ride)              is xml-skip-null                                                          is rw;
  has ProcessorInfo               $.processorInfo                    is xml-element(:over-ride)              is xml-skip-null                                                          is rw;
  has Str                         @.supportedRootDeviceTypes         is xml-element('item')                  is xml-skip-null    is xml-container('supportedRootDeviceTypes')          is rw;   #=  ebs | instance-store
  has Str                         @.supportedUsageClasses            is xml-element('item')                  is xml-skip-null    is xml-container('supportedUsageClasses')             is rw;   #=  spot | on-demand
  has Str                         @.supportedVirtualizationTypes     is xml-element('item')                  is xml-skip-null    is xml-container('supportedVirtualizationTypes')      is rw;   #=  hvm | paravirtual
  has VCpuInfo                    $.vCpuInfo                         is xml-element(:over-ride)              is xml-skip-null                                                          is rw;
}
