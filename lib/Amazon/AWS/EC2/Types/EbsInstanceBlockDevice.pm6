use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;

class Amazon::AWS::EC2::Types::EbsInstanceBlockDevice is export
  does XML::Class[xml-element => 'ebs']
{
  also is Amazon::AWS::EC2::Types::Base;

  # XXX - FINISH HIM!!
}