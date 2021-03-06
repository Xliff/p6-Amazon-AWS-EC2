use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;



class Amazon::AWS::EC2::Types::TransitGatewayAttachmentPropagation is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Str    $.state                         is xml-element    is xml-skip-null          is rw;   #=  enabling | enabled | disabling | disabled
  has Str    $.transitGatewayRouteTableId    is xml-element    is xml-skip-null          is rw; 
}