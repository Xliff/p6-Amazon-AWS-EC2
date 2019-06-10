use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;



class Amazon::AWS::EC2::Types::TransitGatewayRouteAttachment is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Str    $.resourceId                    is xml-element          is rw; 
  has Str    $.resourceType                  is xml-element          is rw;   #=  vpc | vpn
  has Str    $.transitGatewayAttachmentId    is xml-element          is rw; 
}