use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;



class Amazon::AWS::EC2::Types::InstanceCount is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Int    $.instanceCount    is xml-element    is xml-skip-null          is rw; 
  has Str    $.state            is xml-element    is xml-skip-null          is rw;   #=  available | sold | cancelled | pending
}