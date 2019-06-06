use v6.d;

use Amazon::AWS::EC2::EbsInstanceBlockDevice;

use XML::Class;

class Amazon::AWS::EC2::InstanceBlockDeviceMapping is export
  does XML::Class[xml-element => 'item']
{
  has Str                    $.deviceName is xml-element is rw;
  has EbsInstanceBlockDevice $.ebs                       is rw;
}
