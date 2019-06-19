use v6.d;

use XML::Class;

use Amazon::AWS::EC2::Types::Base;

use Amazon::AWS::EC2::Types::CapacityReservationSpecification;
use Amazon::AWS::EC2::Types::CpuOptions;
use Amazon::AWS::EC2::Types::ElasticGpuAssociation;
use Amazon::AWS::EC2::Types::ElasticInferenceAcceleratorAssociation;
use Amazon::AWS::EC2::Types::GroupIdentifier;
use Amazon::AWS::EC2::Types::HibernationOptions;
use Amazon::AWS::EC2::Types::IamInstanceProfile;
use Amazon::AWS::EC2::Types::InstanceBlockDeviceMapping;
use Amazon::AWS::EC2::Types::InstanceNetworkInterface;
use Amazon::AWS::EC2::Types::InstanceState;
use Amazon::AWS::EC2::Types::LicenseConfiguration;
use Amazon::AWS::EC2::Types::Placement;
use Amazon::AWS::EC2::Types::ProductCode;
use Amazon::AWS::EC2::Types::StateReason;
use Amazon::AWS::EC2::Types::Tag;

use Amazon::AWS::EC2::validInstanceTypes;

class Amazon::AWS::EC2::Types::Instance is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Int                                     $.amiLaunchIndex                   is xml-element                        is xml-skip-null is rw;
  has Str                                     $.architecture                     is xml-element                        is xml-skip-null is rw;
  has Str                                     $.capacityReservationId            is xml-element                        is xml-skip-null is rw;
  has CapacityReservationSpecification        $.capacityReservationSpecification is xml-element(:over-ride)            is xml-skip-null is rw;
  has Str                                     $.clientToken                      is xml-element                        is xml-skip-null is rw;
  has CpuOptions                              $.cpuOptions                       is xml-element(:over-ride)            is xml-skip-null is rw;
  has Str                                     $.dnsName                          is xml-element                        is xml-skip-null is rw;
  has Bool                                    $.ebsOptimized                     is xml-element                        is xml-skip-null is rw;
  has Bool                                    $.enaSupport                       is xml-element                        is xml-skip-null is rw;
  has HibernationOptions                      $.hibernationOptions               is xml-element(:over-ride)            is xml-skip-null is rw;
  has Str                                     $.hypervisor                       is xml-element                        is xml-skip-null is rw;
  has IamInstanceProfile                      $.iamInstanceProfile               is xml-element(:over-ride)            is xml-skip-null is rw;
  has Str                                     $.imageId                          is xml-element                        is xml-skip-null is rw;
  has Str                                     $.instanceId                       is xml-element                        is xml-skip-null is rw;
  has Str                                     $.instanceLifecycle                is xml-element                        is xml-skip-null is rw;
  has InstanceState                           $.instanceState                    is xml-element(:over-ride)            is xml-skip-null is rw;
  has Str                                     $.instanceType                     is xml-element                        is xml-skip-null is rw;
  has Str                                     $.ipAddress                        is xml-element                        is xml-skip-null is rw;
  has Str                                     $.kernelId                         is xml-element                        is xml-skip-null is rw;
  has Str                                     $.keyName                          is xml-element                        is xml-skip-null is rw;
  has Placement                               $.placement                        is xml-element(:over-ride)            is xml-skip-null is rw;
  has Str                                     $.platform                         is xml-element                        is xml-skip-null is rw;
  has Str                                     $.privateDnsName                   is xml-element                        is xml-skip-null is rw;
  has Str                                     $.ramdiskId                        is xml-element                        is xml-skip-null is rw;
  has Str                                     $.reason                           is xml-element                        is xml-skip-null is rw;
  has Str                                     $.rootDeviceName                   is xml-element                        is xml-skip-null is rw;
  has Str                                     $.rootDeviceType                   is xml-element                        is xml-skip-null is rw;
  has Bool                                    $.sourceDestCheck                  is xml-element                        is xml-skip-null is rw;
  has Str                                     $.spotInstanceRequestId            is xml-element                        is xml-skip-null is rw;
  has Str                                     $.sirovNetSupport                  is xml-element                        is xml-skip-null is rw;
  has StateReason                             $.stateReason                      is xml-element(:over-ride)            is xml-skip-null is rw;
  has Str                                     $.subnetId                         is xml-element                        is xml-skip-null is rw;
  has Str                                     $.vpcId                            is xml-element                        is xml-skip-null is rw;

  has InstanceBlockDeviceMapping              @.block-device-mappings
    is xml-container('blockDeviceMapping')                                                                             is xml-skip-null is rw;
  has ElasticGpuAssociation                   @.elasticGpuAssociations
    is xml-container('elasticGpuAssociaionSet')                                                                        is xml-skip-null is rw;
  has ElasticInferenceAcceleratorAssociation  @.elasticInferenceAccelatorAssociations
    is xml-container('elasticInferenceAcceleratorAssociationSet')                                                      is xml-skip-null is rw;
  has LicenseConfiguration                    @.licenses
    is xml-container('licenseSet')                                                                                     is xml-skip-null is rw;
    has InstanceNetworkInterface              @.networkInterfaces
    is xml-container('networkInterfaceSet')                                                                            is xml-skip-null is rw;
  has Tag                                     @.tags
    is xml-container('tagSet')                                                                                         is xml-skip-null is rw;

  has GroupIdentifier                         @.groups                           is xml-element('item', :over-ride)
    is xml-container('groupSet')                                                                                       is xml-skip-null is rw;
  has ProductCode                             @.product-codes                    is xml-element('item', :over-ride)
    is xml-container('productCodes')                                                                                   is xml-skip-null is rw;

  # Attribute aliasing.
  # Attach aliases to the specific method with Method::Also.
  method blockDevs           is rw { @!block-device-mappings                   }
  method elasticAssociations is rw { @!elasticInferenceAccelatorAssociations }
  method gpuAssociations     is rw { @!elasticGpuAssociations                  }
  method productCodes        is rw { @!product-codes                           }

  # Throw a typed exception with a message payload!
  method setInstanceType($type, :$fatal) {
    $!instanceType = $type if checkInstanceType($type, no-die => not $fatal);
  }

}
