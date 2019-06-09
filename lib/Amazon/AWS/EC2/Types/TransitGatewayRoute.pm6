use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;

use Amazon::AWS::EC2::Types::TransitGatewayRouteAttachment;

class Amazon::AWS::EC2::Types::TransitGatewayRoute is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Str                              $.destinationCidrBlock         is xml-element                                                       is rw; 
  has Str                              $.state                        is xml-element                                                       is rw;   #=  pending | active | blackhole | deleting | deleted
  has TransitGatewayRouteAttachment    @.transitGatewayAttachments    is xml-element    is xml-container('transitGatewayAttachments')      is rw; 
  has Str                              $.type                         is xml-element                                                       is rw;   #=  static | propagated
}