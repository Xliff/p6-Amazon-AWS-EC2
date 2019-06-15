use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;

use Amazon::AWS::EC2::Types::DiskImageDetail;
use Amazon::AWS::EC2::Types::VolumeDetail;

class Amazon::AWS::EC2::Types::DiskImage is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Str                $.Description    is xml-element    is xml-skip-null          is rw; 
  has DiskImageDetail    $.Image          is xml-element    is xml-skip-null          is rw; 
  has VolumeDetail       $.Volume         is xml-element    is xml-skip-null          is rw; 
}