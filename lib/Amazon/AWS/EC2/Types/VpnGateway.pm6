use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;

use Amazon::AWS::EC2::Types::Tag;
use Amazon::AWS::EC2::Types::VpcAttachment;

class Amazon::AWS::EC2::Types::VpnGateway is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Int              $.amazonSideAsn       is xml-element                                         is rw; 
  has VpcAttachment    @.attachments         is xml-element    is xml-container('attachments')      is rw; 
  has Str              $.availabilityZone    is xml-element                                         is rw; 
  has Str              $.state               is xml-element                                         is rw;   #=  pending | available | deleting | deleted
  has Tag              @.tags                is xml-element    is xml-container('tagSet')           is rw; 
  has Str              $.type                is xml-element                                         is rw;   #=  ipsec.1
  has Str              $.vpnGatewayId        is xml-element                                         is rw; 
}