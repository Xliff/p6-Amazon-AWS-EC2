use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;

use Amazon::AWS::EC2::Types::ReservedInstancesConfiguration;

class Amazon::AWS::EC2::Types::ReservedInstancesModificationResult is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Str                               $.reservedInstancesId    is xml-element          is rw; 
  has ReservedInstancesConfiguration    $.targetConfiguration    is xml-element          is rw; 
}