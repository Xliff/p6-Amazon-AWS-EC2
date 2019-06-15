use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;

use Amazon::AWS::EC2::Types::EbsInstanceBlockDevice;

class Amazon::AWS::EC2::Types::InstanceBlockDeviceMapping is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Str                       $.deviceName    is xml-element    is xml-skip-null          is rw; 
  has EbsInstanceBlockDevice    $.ebs           is xml-element    is xml-skip-null          is rw; 
}