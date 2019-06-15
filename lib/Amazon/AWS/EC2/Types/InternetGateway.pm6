use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;

use Amazon::AWS::EC2::Types::InternetGatewayAttachment;
use Amazon::AWS::EC2::Types::Tag;

class Amazon::AWS::EC2::Types::InternetGateway is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has InternetGatewayAttachment    @.attachments          is xml-element    is xml-skip-null    is xml-container('attachmentSet')      is rw; 
  has Str                          $.internetGatewayId    is xml-element    is xml-skip-null                                           is rw; 
  has Str                          $.ownerId              is xml-element    is xml-skip-null                                           is rw; 
  has Tag                          @.tags                 is xml-element    is xml-skip-null    is xml-container('tagSet')             is rw; 
}