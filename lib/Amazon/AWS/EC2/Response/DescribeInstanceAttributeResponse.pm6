use v6.d;

use Amazon::AWS::Roles::Response;

use XML::Class;

use Amazon::AWS::EC2::Types::AttributeBooleanValue;
use Amazon::AWS::EC2::Types::AttributeValue;
use Amazon::AWS::EC2::Types::GroupIdentifier;
use Amazon::AWS::EC2::Types::InstanceBlockDeviceMapping;
use Amazon::AWS::EC2::Types::ProductCode;

class Amazon::AWS::EC2::Response::DescribeInstanceAttributeResponse is export
  does XML::Class[xml-element => 'DescribeInstanceAttributeResponse']
{
  also does Amazon::AWS::Roles::Response;

  has InstanceBlockDeviceMapping    @.blockDeviceMapping                   is xml-element    is xml-container('blockDeviceMapping')      is rw; 
  has AttributeBooleanValue         $.disableApiTermination                is xml-element                                                is rw; 
  has AttributeBooleanValue         $.ebsOptimized                         is xml-element                                                is rw; 
  has AttributeBooleanValue         $.enaSupport                           is xml-element                                                is rw; 
  has GroupIdentifier               @.groups                               is xml-element    is xml-container('groupSet')                is rw; 
  has Str                           $.instanceId                           is xml-element                                                is rw; 
  has AttributeValue                $.instanceInitiatedShutdownBehavior    is xml-element                                                is rw; 
  has AttributeValue                $.instanceType                         is xml-element                                                is rw; 
  has AttributeValue                $.kernel                               is xml-element                                                is rw; 
  has ProductCode                   @.productCodes                         is xml-element    is xml-container('productCodes')            is rw; 
  has AttributeValue                $.ramdisk                              is xml-element                                                is rw; 
  has AttributeValue                $.rootDeviceName                       is xml-element                                                is rw; 
  has AttributeBooleanValue         $.sourceDestCheck                      is xml-element                                                is rw; 
  has AttributeValue                $.sriovNetSupport                      is xml-element                                                is rw; 
  has AttributeValue                $.userData                             is xml-element                                                is rw; 
}