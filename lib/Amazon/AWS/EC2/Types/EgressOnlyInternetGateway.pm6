use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;

use Amazon::AWS::EC2::Types::InternetGatewayAttachment;

class Amazon::AWS::EC2::Types::EgressOnlyInternetGateway is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has InternetGatewayAttachment    @.attachments                    is xml-element    is xml-container('attachmentSet')      is rw; 
  has Str                          $.egressOnlyInternetGatewayId    is xml-element                                           is rw; 
}