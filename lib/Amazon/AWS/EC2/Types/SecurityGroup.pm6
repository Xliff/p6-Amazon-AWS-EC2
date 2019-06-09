use v6.d;

use XML::Class;

use Amazon::AWS::EC2::Types::Base;
use Amazon::AWS::EC2::Types::IpPermission;
use Amazon::AWS::EC2::Types::Tag;

class Amazon::AWS::EC2::Types::SecurityGroup is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;
  
  has Str          $.groupDecision        is xml-element is rw;
  has Str          $.groupId              is xml-element is rw;
  has Str          $.groupName            is xml-element is rw;
  has Str          $.ownerId              is xml-element is rw;
  has Str          $.vpcId                is xml-element is rw;

  has IpPermission @.ipPermissions        
    is xml-container('ipPermissions')                    is rw;
  has IpPermission @.ipPermissionsEgrewss 
    is xml-container('ipPermissionEgress')               is rw;
  has Tag          @.tags                 
    is xml-container('tagSet')                           is rw;

}
