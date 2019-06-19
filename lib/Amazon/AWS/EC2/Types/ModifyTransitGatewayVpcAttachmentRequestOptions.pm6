use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;



class Amazon::AWS::EC2::Types::ModifyTransitGatewayVpcAttachmentRequestOptions is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Str    $.DnsSupport     is xml-element    is xml-skip-null          is rw;   #=  enable | disable
  has Str    $.Ipv6Support    is xml-element    is xml-skip-null          is rw;   #=  enable | disable
}