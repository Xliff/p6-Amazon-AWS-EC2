use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;



class Amazon::AWS::EC2::Types::DiskImageDescription is export
  does XML::Class
{
  also is Amazon::AWS::EC2::Types::Base;

  has Str    $.checksum             is xml-element    is xml-skip-null          is rw;
  has Str    $.format               is xml-element    is xml-skip-null          is rw;   #=  VMDK | RAW | VHD
  has Str    $.importManifestUrl    is xml-element    is xml-skip-null          is rw;
  has Int    $.size                 is xml-element    is xml-skip-null          is rw;
}
