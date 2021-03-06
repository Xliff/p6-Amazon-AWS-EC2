use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;



class Amazon::AWS::EC2::Types::InstanceCapacity is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Int    $.availableCapacity    is xml-element    is xml-skip-null          is rw; 
  has Str    $.instanceType         is xml-element    is xml-skip-null          is rw; 
  has Int    $.totalCapacity        is xml-element    is xml-skip-null          is rw; 
}