use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;

use Amazon::AWS::EC2::Types::Tag;
use Amazon::AWS::EC2::Types::TransitGatewayOptions;

class Amazon::AWS::EC2::Types::TransitGateway is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Str                      $.creationTime         is xml-element                is xml-skip-null                                    is rw;
  has Str                      $.description          is xml-element                is xml-skip-null                                    is rw;
  has TransitGatewayOptions    $.options              is xml-element(:over-ride)    is xml-skip-null                                    is rw;
  has Str                      $.ownerId              is xml-element                is xml-skip-null                                    is rw;
  has Str                      $.state                is xml-element                is xml-skip-null                                    is rw;   #=  pending | available | modifying | deleting | deleted
  has Tag                      @.tags                                               is xml-skip-null    is xml-container('tagSet')      is rw;
  has Str                      $.transitGatewayArn    is xml-element                is xml-skip-null                                    is rw;
  has Str                      $.transitGatewayId     is xml-element                is xml-skip-null                                    is rw;
}
