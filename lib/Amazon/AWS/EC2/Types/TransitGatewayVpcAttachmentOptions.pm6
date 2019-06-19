use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;



class Amazon::AWS::EC2::Types::TransitGatewayVpcAttachmentOptions is export
  does XML::Class
{
  also is Amazon::AWS::EC2::Types::Base;

  has Str    $.dnsSupport     is xml-element    is xml-skip-null          is rw;   #=  enable | disable
  has Str    $.ipv6Support    is xml-element    is xml-skip-null          is rw;   #=  enable | disable
}
