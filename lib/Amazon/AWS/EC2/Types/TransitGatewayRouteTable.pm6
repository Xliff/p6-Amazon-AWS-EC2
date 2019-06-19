use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;

use Amazon::AWS::EC2::Types::Tag;

class Amazon::AWS::EC2::Types::TransitGatewayRouteTable is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Str     $.creationTime                    is xml-element    is xml-skip-null                                    is rw; 
  has Bool    $.defaultAssociationRouteTable    is xml-element    is xml-skip-null                                    is rw; 
  has Bool    $.defaultPropagationRouteTable    is xml-element    is xml-skip-null                                    is rw; 
  has Str     $.state                           is xml-element    is xml-skip-null                                    is rw;   #=  pending | available | deleting | deleted
  has Tag     @.tags                            is xml-element    is xml-skip-null    is xml-container('tagSet')      is rw; 
  has Str     $.transitGatewayId                is xml-element    is xml-skip-null                                    is rw; 
  has Str     $.transitGatewayRouteTableId      is xml-element    is xml-skip-null                                    is rw; 
}