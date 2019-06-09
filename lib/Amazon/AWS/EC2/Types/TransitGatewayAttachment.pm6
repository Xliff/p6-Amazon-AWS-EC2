use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;

use Amazon::AWS::EC2::Types::Tag;
use Amazon::AWS::EC2::Types::TransitGatewayAttachmentAssociation;

class Amazon::AWS::EC2::Types::TransitGatewayAttachment is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has TransitGatewayAttachmentAssociation    $.association                   is xml-element                                    is rw; 
  has Str                                    $.creationTime                  is xml-element                                    is rw; 
  has Str                                    $.resourceId                    is xml-element                                    is rw; 
  has Str                                    $.resourceOwnerId               is xml-element                                    is rw; 
  has Str                                    $.resourceType                  is xml-element                                    is rw;   #=  vpc | vpn
  has Str                                    $.state                         is xml-element                                    is rw;   #=  pendingAcceptance | rollingBack | pending | available | modifying | deleting | deleted | failed | rejected | rejecting | failing
  has Tag                                    @.tags                          is xml-element    is xml-container('tagSet')      is rw; 
  has Str                                    $.transitGatewayAttachmentId    is xml-element                                    is rw; 
  has Str                                    $.transitGatewayId              is xml-element                                    is rw; 
  has Str                                    $.transitGatewayOwnerId         is xml-element                                    is rw; 
}