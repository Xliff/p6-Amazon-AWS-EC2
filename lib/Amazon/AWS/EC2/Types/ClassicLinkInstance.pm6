use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;

use Amazon::AWS::EC2::Types::GroupIdentifier;
use Amazon::AWS::EC2::Types::Tag;

class Amazon::AWS::EC2::Types::ClassicLinkInstance is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has GroupIdentifier    @.groups        is xml-element    is xml-container('groupSet')      is rw; 
  has Str                $.instanceId    is xml-element                                      is rw; 
  has Tag                @.tags          is xml-element    is xml-container('tagSet')        is rw; 
  has Str                $.vpcId         is xml-element                                      is rw; 
}