use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;



class Amazon::AWS::EC2::Types::DiskImageVolumeDescription is export
  does XML::Class
{
  also is Amazon::AWS::EC2::Types::Base;

  has Str    $.id      is xml-element    is xml-skip-null          is rw;
  has Int    $.size    is xml-element    is xml-skip-null          is rw;
}
