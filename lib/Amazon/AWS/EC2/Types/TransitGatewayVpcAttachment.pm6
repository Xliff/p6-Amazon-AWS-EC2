use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;

use Amazon::AWS::EC2::Types::Tag;
use Amazon::AWS::EC2::Types::TransitGatewayVpcAttachmentOptions;

class Amazon::AWS::EC2::Types::TransitGatewayVpcAttachment is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Str                                   $.creationTime                  is xml-element    is xml-skip-null                                       is rw; 
  has TransitGatewayVpcAttachmentOptions    $.options                       is xml-element    is xml-skip-null                                       is rw; 
  has Str                                   $.state                         is xml-element    is xml-skip-null                                       is rw;   #=  pendingAcceptance | rollingBack | pending | available | modifying | deleting | deleted | failed | rejected | rejecting | failing
  has Str                                   @.subnetIds                     is xml-element    is xml-skip-null    is xml-container('subnetIds')      is rw; 
  has Tag                                   @.tags                          is xml-element    is xml-skip-null    is xml-container('tagSet')         is rw; 
  has Str                                   $.transitGatewayAttachmentId    is xml-element    is xml-skip-null                                       is rw; 
  has Str                                   $.transitGatewayId              is xml-element    is xml-skip-null                                       is rw; 
  has Str                                   $.vpcId                         is xml-element    is xml-skip-null                                       is rw; 
  has Str                                   $.vpcOwnerId                    is xml-element    is xml-skip-null                                       is rw; 
}