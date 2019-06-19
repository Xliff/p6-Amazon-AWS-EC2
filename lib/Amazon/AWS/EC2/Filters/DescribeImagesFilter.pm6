use v6.d;

use XML::Class;

use Amazon::AWS::Roles::Base;
use Amazon::AWS::Roles::Eqv;

class Amazon::AWS::EC2::Filters::DescribeImagesFilter::BlockDeviceMapping
  does XML::Class[xml-element => 'block-device-mapping']
{
  also does Amazon::AWS::Roles::Base;
  also does Amazon::AWS::Roles::Eqv;

  has Bool                $.delete-on-termination                               is xml-element   is rw;
  has Str                 $.device-name                                         is xml-element   is rw;
  has Str                 $.snapshot-id                                         is xml-element   is rw;
  has Int                 $.volume-size                                         is xml-element   is rw;
  has Str                 $.volume-type                                         is xml-element   is rw;  #= gp2 | io1 | st1 | sc1 | standard
  has Bool                $.encrypted                                           is xml-element   is rw;
}

class Amazon::AWS::EC2::Filters::DescribeImagesFilter::Tag
  does XML::Class[xml-element => 'item']
{
  also does Amazon::AWS::Roles::Base;
  also does Amazon::AWS::Roles::Eqv;

  has Str                 $.key                                                 is xml-element   is rw;
  has Str                 $.value                                               is xml-element   is rw;
}

# See if we can make this a reusable type.
class Amazon::AWS::EC2::Filters::DescribeImagesFilter::ProductCode
  does XML::Class[xml-element => 'product-code']
{
  also does Amazon::AWS::Roles::Base;
  also does Amazon::AWS::Roles::Eqv;

  has Str                 $.type                                                is xml-element   is rw;  #= devpay | marketplace
}

constant BlockDeviceMapping := Amazon::AWS::EC2::Filters::DescribeImagesFilter::BlockDeviceMapping;
constant ProductCode        := Amazon::AWS::EC2::Filters::DescribeImagesFilter::ProductCode;
constant Tag                := Amazon::AWS::EC2::Filters::DescribeImagesFilter::Tag;

class Amazon::AWS::EC2::Filters::DescribeImagesFilter is export
  does XML::Class
{
  also does Amazon::AWS::Roles::Base;
  also does Amazon::AWS::Roles::Eqv;

  has Str                 $.architecture                                        is xml-element   is rw;  #= i386 | x86_64 | arm64
  has BlockDeviceMapping  $.block-device-mapping                                                 is rw;
  has Str                 $.description                                         is xml-element   is rw;
  has Bool                $.ena-support                                         is xml-element   is rw;
  has Str                 $.hypervisor                                          is xml-element   is rw;  #= xen | ovm
  has Str                 $.image-id                                            is xml-element   is rw;
  has Str                 $.image-type                                          is xml-element   is rw;  #= machine | kernel | ramdisk
  has Bool                $.is-public                                           is xml-element   is rw;
  has Str                 $.kernel-id                                           is xml-element   is rw;
  has Str                 $.manifest-location                                   is xml-element   is rw;
  has Str                 $.name                                                is xml-element   is rw;
  has Str                 $.owner-alias                                         is xml-element   is rw;  #= amazon | aws-marketplace | microsoft
  has Str                 $.owner-id                                            is xml-element   is rw;
  has Str                 $.platform                                            is xml-element   is rw;
  has Str                 $.product-code-id                                     is xml-element   is rw;
  has ProductCode         $.product-code                                                         is rw;
  has Str                 $.ramdisk-id                                          is xml-element   is rw;
  has Str                 $.root-device-name                                    is xml-element   is rw;
  has Str                 $.root-device-type                                    is xml-element   is rw;  #= ebs | instance-store
  has Str                 $.state                                               is xml-element   is rw;  #= available | pending | failed
  has Str                 $.state-reason-code                                   is xml-element   is rw;
  has Str                 $.state-reason-message                                is xml-element   is rw;
  has Str                 $.sriov-net-support                                   is xml-element   is rw;  #= simple
  has Tag                 @.tags                  is xml-container('tagSet')                     is rw;
  has Str                 $.tag-key                                             is xml-element   is rw;
  has Str                 $.virtualization-type                                 is xml-element   is rw;  #= paravirtual | hvm
}
