use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;

use Amazon::AWS::EC2::Types::IamInstanceProfile;

class Amazon::AWS::EC2::Types::IamInstanceProfileAssociation is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Str                   $.associationId         is xml-element          is rw; 
  has IamInstanceProfile    $.iamInstanceProfile    is xml-element          is rw; 
  has Str                   $.instanceId            is xml-element          is rw; 
  has Str                   $.state                 is xml-element          is rw;   #=  associating | associated | disassociating | disassociated
  has Str                   $.timestamp             is xml-element          is rw; 
}