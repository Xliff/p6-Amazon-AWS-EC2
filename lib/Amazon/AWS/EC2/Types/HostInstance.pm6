use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;



class Amazon::AWS::EC2::Types::HostInstance is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Str    $.instanceId      is xml-element          is rw; 
  has Str    $.instanceType    is xml-element          is rw; 
}