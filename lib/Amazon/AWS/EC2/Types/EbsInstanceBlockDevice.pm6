use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;

class Amazon::AWS::EC2::Types::EbsInstanceBlockDevice is export
  does XML::Class[xml-element => 'ebs']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Str  $.attachTime           is xml-element is rw;
  has Bool $.deleteOnTermination  is xml-element is rw;
  has Str  $.status               is xml-element is rw; #= attaching | attached | detaching | detached
  has Str  $.volumeId             is xml-element is rw;
}
