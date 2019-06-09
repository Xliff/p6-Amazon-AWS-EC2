use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;



class Amazon::AWS::EC2::Types::NatGatewayAddress is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Str    $.allocationId          is xml-element          is rw; 
  has Str    $.networkInterfaceId    is xml-element          is rw; 
  has Str    $.privateIp             is xml-element          is rw; 
  has Str    $.publicIp              is xml-element          is rw; 
}