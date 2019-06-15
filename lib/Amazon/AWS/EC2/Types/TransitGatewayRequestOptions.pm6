use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;



class Amazon::AWS::EC2::Types::TransitGatewayRequestOptions is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Int    $.AmazonSideAsn                   is xml-element    is xml-skip-null          is rw; 
  has Str    $.AutoAcceptSharedAttachments     is xml-element    is xml-skip-null          is rw;   #=  enable | disable
  has Str    $.DefaultRouteTableAssociation    is xml-element    is xml-skip-null          is rw;   #=  enable | disable
  has Str    $.DefaultRouteTablePropagation    is xml-element    is xml-skip-null          is rw;   #=  enable | disable
  has Str    $.DnsSupport                      is xml-element    is xml-skip-null          is rw;   #=  enable | disable
  has Str    $.VpnEcmpSupport                  is xml-element    is xml-skip-null          is rw;   #=  enable | disable
}