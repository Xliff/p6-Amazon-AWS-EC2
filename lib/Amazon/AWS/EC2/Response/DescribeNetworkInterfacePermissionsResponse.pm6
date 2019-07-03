use v6.d;

use Amazon::AWS::Roles::Response;

use XML::Class;

use Amazon::AWS::EC2::Types::NetworkInterfacePermission;

class Amazon::AWS::EC2::Response::DescribeNetworkInterfacePermissionsResponse is export
  does XML::Class[xml-element => 'DescribeNetworkInterfacePermissionsResponse']
{
  also does Amazon::AWS::Roles::Response;

  has NetworkInterfacePermission    @.networkInterfacePermissions                  is xml-container('networkPermissionSet')  is rw; 
  has Str                           $.nextToken                    is xml-element                                            is rw; 
}
