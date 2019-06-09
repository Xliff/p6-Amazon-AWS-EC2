use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;

use Amazon::AWS::EC2::Types::DhcpConfiguration;
use Amazon::AWS::EC2::Types::Tag;

class Amazon::AWS::EC2::Types::DhcpOptions is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has DhcpConfiguration    @.dhcpConfigurations    is xml-element    is xml-container('dhcpConfigurationSet')      is rw; 
  has Str                  $.dhcpOptionsId         is xml-element                                                  is rw; 
  has Str                  $.ownerId               is xml-element                                                  is rw; 
  has Tag                  @.tags                  is xml-element    is xml-container('tagSet')                    is rw; 
}