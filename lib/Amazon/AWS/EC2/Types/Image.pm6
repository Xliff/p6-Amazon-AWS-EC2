use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;

use Amazon::AWS::EC2::Types::BlockDeviceMapping;
use Amazon::AWS::EC2::Types::ProductCode;
use Amazon::AWS::EC2::Types::StateReason;
use Amazon::AWS::EC2::Types::Tag;

class Amazon::AWS::EC2::Types::Image is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Str                   $.architecture          is xml-element                is xml-skip-null                                                is rw;   #=  i386 | x86_64 | arm64
  has BlockDeviceMapping    @.blockDeviceMapping    is xml-element(:over-ride)    is xml-skip-null    is xml-container('blockDeviceMapping')      is rw;
  has Str                   $.creationDate          is xml-element                is xml-skip-null                                                is rw; 
  has Str                   $.description           is xml-element                is xml-skip-null                                                is rw; 
  has Bool                  $.enaSupport            is xml-element                is xml-skip-null                                                is rw; 
  has Str                   $.hypervisor            is xml-element                is xml-skip-null                                                is rw;   #=  ovm | xen
  has Str                   $.imageId               is xml-element                is xml-skip-null                                                is rw; 
  has Str                   $.imageLocation         is xml-element                is xml-skip-null                                                is rw; 
  has Str                   $.imageOwnerAlias       is xml-element                is xml-skip-null                                                is rw; 
  has Str                   $.imageOwnerId          is xml-element                is xml-skip-null                                                is rw; 
  has Str                   $.imageState            is xml-element                is xml-skip-null                                                is rw;   #=  pending | available | invalid | deregistered | transient | failed | error
  has Str                   $.imageType             is xml-element                is xml-skip-null                                                is rw;   #=  machine | kernel | ramdisk
  has Bool                  $.isPublic              is xml-element                is xml-skip-null                                                is rw; 
  has Str                   $.kernelId              is xml-element                is xml-skip-null                                                is rw; 
  has Str                   $.name                  is xml-element                is xml-skip-null                                                is rw; 
  has Str                   $.platform              is xml-element                is xml-skip-null                                                is rw;   #=  Windows
  has ProductCode           @.productCodes          is xml-element(:over-ride)    is xml-skip-null    is xml-container('productCodes')            is rw;
  has Str                   $.ramdiskId             is xml-element                is xml-skip-null                                                is rw;
  has Str                   $.rootDeviceName        is xml-element                is xml-skip-null                                                is rw;
  has Str                   $.rootDeviceType        is xml-element                is xml-skip-null                                                is rw;   #=  ebs | instance-store
  has Str                   $.sriovNetSupport       is xml-element                is xml-skip-null                                                is rw;
  has StateReason           $.stateReason           is xml-element(:over-ride)    is xml-skip-null                                                is rw;
  has Tag                   @.tags                                                is xml-skip-null    is xml-container('tagSet')                  is rw;
  has Str                   $.virtualizationType    is xml-element                is xml-skip-null                                                is rw;   #=  hvm | paravirtual
}
