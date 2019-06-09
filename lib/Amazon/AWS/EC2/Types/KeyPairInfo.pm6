use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;



class Amazon::AWS::EC2::Types::KeyPairInfo is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Str    $.keyFingerprint    is xml-element          is rw; 
  has Str    $.keyName           is xml-element          is rw; 
}