use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;

use Amazon::AWS::EC2::Types::Tag;

class Amazon::AWS::EC2::Types::CustomerGateway is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Str    $.bgpAsn               is xml-element                                    is rw; 
  has Str    $.customerGatewayId    is xml-element                                    is rw; 
  has Str    $.ipAddress            is xml-element                                    is rw; 
  has Str    $.state                is xml-element                                    is rw; 
  has Tag    @.tags                 is xml-element    is xml-container('tagSet')      is rw; 
  has Str    $.type                 is xml-element                                    is rw; 
}