use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;



class Amazon::AWS::EC2::Types::DnsServersOptionsModifyStructure is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Str     @.CustomDnsServers    is xml-element    is xml-container('CustomDnsServers')      is rw; 
  has Bool    $.Enabled             is xml-element                                              is rw; 
}