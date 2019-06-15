use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;



class Amazon::AWS::EC2::Types::DiskImageDetail is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Int    $.Bytes                is xml-element    is xml-skip-null          is rw; 
  has Str    $.Format               is xml-element    is xml-skip-null          is rw;   #=  VMDK | RAW | VHD
  has Str    $.ImportManifestUrl    is xml-element    is xml-skip-null          is rw; 
}