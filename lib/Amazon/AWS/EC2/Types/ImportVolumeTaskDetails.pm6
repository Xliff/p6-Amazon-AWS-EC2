use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;

use Amazon::AWS::EC2::Types::DiskImageDescription;
use Amazon::AWS::EC2::Types::DiskImageVolumeDescription;

class Amazon::AWS::EC2::Types::ImportVolumeTaskDetails is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Str                           $.availabilityZone    is xml-element          is rw; 
  has Int                           $.bytesConverted      is xml-element          is rw; 
  has Str                           $.description         is xml-element          is rw; 
  has DiskImageDescription          $.image               is xml-element          is rw; 
  has DiskImageVolumeDescription    $.volume              is xml-element          is rw; 
}