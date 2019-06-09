use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;

use Amazon::AWS::EC2::Types::VpcCidrBlockState;

class Amazon::AWS::EC2::Types::VpcIpv6CidrBlockAssociation is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Str                  $.associationId         is xml-element          is rw; 
  has Str                  $.ipv6CidrBlock         is xml-element          is rw; 
  has VpcCidrBlockState    $.ipv6CidrBlockState    is xml-element          is rw; 
}