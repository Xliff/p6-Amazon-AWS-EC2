use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;

use Amazon::AWS::EC2::Types::EbsBlockDevice;

class Amazon::AWS::EC2::Types::BlockDeviceMapping is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Str               $.DeviceName     is xml-element                is xml-skip-null          is rw;
  has Str               $.deviceName     is xml-element                is xml-skip-null          is rw;
  has EbsBlockDevice    $.Ebs            is xml-element(:over-ride)    is xml-skip-null          is rw;
  has EbsBlockDevice    $.ebs            is xml-element(:over-ride)    is xml-skip-null          is rw;
  has Str               $.NoDevice       is xml-element                is xml-skip-null          is rw;
  has Str               $.noDevice       is xml-element                is xml-skip-null          is rw;
  has Str               $.VirtualName    is xml-element                is xml-skip-null          is rw;
  has Str               $.virtualName    is xml-element                is xml-skip-null          is rw;
}
