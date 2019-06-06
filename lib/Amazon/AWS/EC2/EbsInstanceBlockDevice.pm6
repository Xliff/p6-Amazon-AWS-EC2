use v6.d;

use Amazon::AWS::EC2::Base;

use XML::Class;

class Amazon::AWS::EC2::EbsInstanceBlockDevice is export
  does XML::Class[xml-element => 'ebs']
{
  also is Amazon::AWS::EC2::Base;

  # XXX - FINISH HIM!!
}