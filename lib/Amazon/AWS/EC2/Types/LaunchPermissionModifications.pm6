use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;

use Amazon::AWS::EC2::Types::LaunchPermission;

class Amazon::AWS::EC2::Types::LaunchPermissionModifications is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has LaunchPermission    @.Add       is xml-element    is xml-skip-null    is xml-container('Add')         is rw; 
  has LaunchPermission    @.Remove    is xml-element    is xml-skip-null    is xml-container('Remove')      is rw; 
}