use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;

use Amazon::AWS::EC2::Types::VpcCidrBlockState;

class Amazon::AWS::EC2::Types::VpcCidrBlockAssociation is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Str                  $.associationId     is xml-element                is xml-skip-null          is rw; 
  has Str                  $.cidrBlock         is xml-element                is xml-skip-null          is rw; 
  has VpcCidrBlockState    $.cidrBlockState    is xml-element(:over-ride)    is xml-skip-null          is rw;
}
