use v6.d;

use Amazon::AWS::Roles::Response;

use XML::Class;

use Amazon::AWS::EC2::Types::AttributeValue;
use Amazon::AWS::EC2::Types::BlockDeviceMapping;
use Amazon::AWS::EC2::Types::LaunchPermission;
use Amazon::AWS::EC2::Types::ProductCode;

class Amazon::AWS::EC2::Response::DescribeImageAttributeResponse is export
  does XML::Class[xml-element => 'DescribeImageAttributeResponse']
{
  also does Amazon::AWS::Roles::Response;

  has BlockDeviceMapping    @.blockDeviceMapping    is xml-element('item',            :over-ride)    is xml-container('blockDeviceMapping')   is xml-skip-null is rw; 
  has AttributeValue        $.description           is xml-element('description',     :over-ride)                                             is xml-skip-null is rw; 
  has Str                   $.imageId               is xml-element                                                                            is xml-skip-null is rw; 
  has AttributeValue        $.kernel                is xml-element('kernel',          :over-ride)                                             is xml-skip-null is rw; 
  has LaunchPermission      @.launchPermission                                                       is xml-container('launchPermission')     is xml-skip-null is rw; 
  has ProductCode           @.productCodes          is xml-element('item',            :over-ride)    is xml-container('productCodes')         is xml-skip-null is rw; 
  has AttributeValue        $.ramdisk               is xml-element('ramdisk',         :over-ride)                                             is xml-skip-null is rw; 
  has AttributeValue        $.sriovNetSupport       is xml-element('sriovNetSupport', :over-ride)                                             is xml-skip-null is rw; 
}
