use v6.c;

use XML::Class;

class Amazon::AWS::EC2::InstanceState is export
  does XML::Class[xml-element => 'instanceState']
{
  also is Amazon::AWS::EC2::Base;

  has Int $.code is xml-element is rw;
  has Str $.name is xml-element is rw;
}