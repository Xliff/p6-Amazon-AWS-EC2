use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;

use Amazon::AWS::EC2::Types::LaunchTemplateEbsBlockDeviceRequest;

class Amazon::AWS::EC2::Types::LaunchTemplateBlockDeviceMappingRequest is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Str                                    $.DeviceName     is xml-element    is xml-skip-null          is rw; 
  has LaunchTemplateEbsBlockDeviceRequest    $.Ebs            is xml-element    is xml-skip-null          is rw; 
  has Str                                    $.NoDevice       is xml-element    is xml-skip-null          is rw; 
  has Str                                    $.VirtualName    is xml-element    is xml-skip-null          is rw; 
}