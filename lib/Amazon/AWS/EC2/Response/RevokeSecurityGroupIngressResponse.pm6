use v6.d;

use Amazon::AWS::Roles::Response;

use XML::Class;

use Amazon::AWS::EC2::Types::IpPermission;

class Amazon::AWS::EC2::Response::RevokeSecurityGroupIngressResponse is export
  does XML::Class[xml-element => 'RevokeSecurityGroupIngressResponse']
{
  also does Amazon::AWS::Roles::Response;

  has Bool            $.return                  is xml-element                        is xml-skip-null                                                    is rw; 
  has IpPermission    @.unknownIpPermissions    is xml-element('item', :over-ride)    is xml-skip-null    is xml-container('unknownIpPermissionSet')      is rw; 
}
