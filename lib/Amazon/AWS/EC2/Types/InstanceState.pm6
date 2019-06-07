use v6.c;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;

class Amazon::AWS::EC2::Types::InstanceState is export
  does XML::Class[xml-element => 'instanceState']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Int $.code is xml-element is rw;
  has Str $.name is xml-element is rw;
}
