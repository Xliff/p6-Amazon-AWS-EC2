use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;



class Amazon::AWS::EC2::Types::TransitGatewayOptions is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Int    $.amazonSideAsn                     is xml-element    is xml-skip-null          is rw; 
  has Str    $.associationDefaultRouteTableId    is xml-element    is xml-skip-null          is rw; 
  has Str    $.autoAcceptSharedAttachments       is xml-element    is xml-skip-null          is rw;   #=  enable | disable
  has Str    $.defaultRouteTableAssociation      is xml-element    is xml-skip-null          is rw;   #=  enable | disable
  has Str    $.defaultRouteTablePropagation      is xml-element    is xml-skip-null          is rw;   #=  enable | disable
  has Str    $.dnsSupport                        is xml-element    is xml-skip-null          is rw;   #=  enable | disable
  has Str    $.propagationDefaultRouteTableId    is xml-element    is xml-skip-null          is rw; 
  has Str    $.vpnEcmpSupport                    is xml-element    is xml-skip-null          is rw;   #=  enable | disable
}