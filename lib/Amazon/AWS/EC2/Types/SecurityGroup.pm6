use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;

use Amazon::AWS::EC2::Types::IpPermission;
use Amazon::AWS::EC2::Types::Tag;

class Amazon::AWS::EC2::Types::SecurityGroup is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Str             $.groupDescription       is xml-element    is xml-skip-null                                                 is rw; 
  has Str             $.groupId                is xml-element    is xml-skip-null                                                 is rw; 
  has Str             $.groupName              is xml-element    is xml-skip-null                                                 is rw; 
  has IpPermission    @.ipPermissions          is xml-element    is xml-skip-null    is xml-container('ipPermissions')            is rw; 
  has IpPermission    @.ipPermissionsEgress    is xml-element    is xml-skip-null    is xml-container('ipPermissionsEgress')      is rw; 
  has Str             $.ownerId                is xml-element    is xml-skip-null                                                 is rw; 
  has Tag             @.tags                   is xml-element    is xml-skip-null    is xml-container('tagSet')                   is rw; 
  has Str             $.vpcId                  is xml-element    is xml-skip-null                                                 is rw; 
}