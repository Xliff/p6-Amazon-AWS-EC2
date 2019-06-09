use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;

use Amazon::AWS::EC2::Types::CreateVolumePermission;
use Amazon::AWS::EC2::Types::CreateVolumePermission;

class Amazon::AWS::EC2::Types::CreateVolumePermissionModifications is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has CreateVolumePermission    @.Add       is xml-element    is xml-container('Add')         is rw; 
  has CreateVolumePermission    @.Remove    is xml-element    is xml-container('Remove')      is rw; 
}