use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;

use Amazon::AWS::EC2::Types::StaleIpPermission;
use Amazon::AWS::EC2::Types::StaleIpPermission;

class Amazon::AWS::EC2::Types::StaleSecurityGroup is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Str                  $.description                 is xml-element                                                      is rw; 
  has Str                  $.groupId                     is xml-element                                                      is rw; 
  has Str                  $.groupName                   is xml-element                                                      is rw; 
  has StaleIpPermission    @.staleIpPermissions          is xml-element    is xml-container('staleIpPermissions')            is rw; 
  has StaleIpPermission    @.staleIpPermissionsEgress    is xml-element    is xml-container('staleIpPermissionsEgress')      is rw; 
  has Str                  $.vpcId                       is xml-element                                                      is rw; 
}