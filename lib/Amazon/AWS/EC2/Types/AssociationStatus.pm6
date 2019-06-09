use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;



class Amazon::AWS::EC2::Types::AssociationStatus is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Str    $.code       is xml-element          is rw;   #=  associating | associated | association-failed | disassociating | disassociated
  has Str    $.message    is xml-element          is rw; 
}