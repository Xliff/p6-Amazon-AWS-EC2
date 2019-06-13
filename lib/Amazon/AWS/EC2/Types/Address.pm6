use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;

use Amazon::AWS::EC2::Types::Tag;

class Amazon::AWS::EC2::Types::Address is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Str    $.allocationId               is xml-element                                  is rw;
  has Str    $.associationId              is xml-element                                  is rw;
  has Str    $.domain                     is xml-element                                  is rw;   #=  vpc | standard
  has Str    $.instanceId                 is xml-element                                  is rw;
  has Str    $.networkInterfaceId         is xml-element                                  is rw;
  has Str    $.networkInterfaceOwnerId    is xml-element                                  is rw;
  has Str    $.privateIpAddress           is xml-element                                  is rw;
  has Str    $.publicIp                   is xml-element                                  is rw;
  has Str    $.publicIpv4Pool             is xml-element                                  is rw;
  has Tag    @.tags                                         is xml-container('tagSet')    is rw;
}
