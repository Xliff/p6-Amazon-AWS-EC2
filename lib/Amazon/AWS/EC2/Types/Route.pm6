use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;



class Amazon::AWS::EC2::Types::Route is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Str    $.destinationCidrBlock           is xml-element          is rw; 
  has Str    $.destinationIpv6CidrBlock       is xml-element          is rw; 
  has Str    $.destinationPrefixListId        is xml-element          is rw; 
  has Str    $.egressOnlyInternetGatewayId    is xml-element          is rw; 
  has Str    $.gatewayId                      is xml-element          is rw; 
  has Str    $.instanceId                     is xml-element          is rw; 
  has Str    $.instanceOwnerId                is xml-element          is rw; 
  has Str    $.natGatewayId                   is xml-element          is rw; 
  has Str    $.networkInterfaceId             is xml-element          is rw; 
  has Str    $.origin                         is xml-element          is rw;   #=  CreateRouteTable | CreateRoute | EnableVgwRoutePropagation
  has Str    $.state                          is xml-element          is rw;   #=  active | blackhole
  has Str    $.transitGatewayId               is xml-element          is rw; 
  has Str    $.vpcPeeringConnectionId         is xml-element          is rw; 
}