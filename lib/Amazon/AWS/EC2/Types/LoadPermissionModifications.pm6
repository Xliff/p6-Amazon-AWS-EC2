use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;

use Amazon::AWS::EC2::Types::LoadPermissionRequest;
use Amazon::AWS::EC2::Types::LoadPermissionRequest;

class Amazon::AWS::EC2::Types::LoadPermissionModifications is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has LoadPermissionRequest    @.Add       is xml-element    is xml-container('Add')         is rw; 
  has LoadPermissionRequest    @.Remove    is xml-element    is xml-container('Remove')      is rw; 
}