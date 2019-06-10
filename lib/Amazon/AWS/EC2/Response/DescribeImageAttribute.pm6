use v6.d;

use Amazon::AWS::Roles::Response;

use XML::Class;

use Amazon::AWS::EC2::Types::AttributeValue;
use Amazon::AWS::EC2::Types::BlockDeviceMapping;
use Amazon::AWS::EC2::Types::LaunchPermission;
use Amazon::AWS::EC2::Types::ProductCode;

class Amazon::AWS::EC2::Types::Response::DescribeImageAttributeResponse is export
  does XML::Class[xml-element => 'item']
{
  also does Amazon::AWS::Roles::Response;

  has BlockDeviceMapping    @.blockDeviceMapping    is xml-element    is xml-container('blockDeviceMapping')      is rw; 
  has AttributeValue        $.description           is xml-element                                                is rw; 
  has Str                   $.imageId               is xml-element                                                is rw; 
  has AttributeValue        $.kernel                is xml-element                                                is rw; 
  has LaunchPermission      @.launchPermission      is xml-element    is xml-container('launchPermission')        is rw; 
  has ProductCode           @.productCodes          is xml-element    is xml-container('productCodes')            is rw; 
  has AttributeValue        $.ramdisk               is xml-element                                                is rw; 
  has AttributeValue        $.sriovNetSupport       is xml-element                                                is rw; 
}