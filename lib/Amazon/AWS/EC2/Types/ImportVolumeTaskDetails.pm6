use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;

use Amazon::AWS::EC2::Types::DiskImageDescription;
use Amazon::AWS::EC2::Types::DiskImageVolumeDescription;

class Amazon::AWS::EC2::Types::ImportVolumeTaskDetails is export
  does XML::Class
{
  also is Amazon::AWS::EC2::Types::Base;

  has Str                           $.availabilityZone    is xml-element                          is xml-skip-null          is rw;
  has Int                           $.bytesConverted      is xml-element                          is xml-skip-null          is rw;
  has Str                           $.description         is xml-element                          is xml-skip-null          is rw;
  has DiskImageDescription          $.image               is xml-element('image',  :over-ride)    is xml-skip-null          is rw;
  has DiskImageVolumeDescription    $.volume              is xml-element('volume', :over-ride)    is xml-skip-null          is rw;
}
