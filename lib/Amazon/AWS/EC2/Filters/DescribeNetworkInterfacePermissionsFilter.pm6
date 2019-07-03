use v6.d;

use Amazon::AWS::Roles::Base;
use Amazon::AWS::Roles::Eqv;

use Amazon::AWS::Utils;

use XML::Class;

my %attributes;

class Amazon::AWS::EC2::Filters::DescribeNetworkInterfacePermissionsFilter::NetworkInterfacePermission
  does XML::Class[xml-element => 'network-interface-permission']
{
  also does Amazon::AWS::Roles::Base;
  also does Amazon::AWS::Roles::Eqv;
    
  has Str $.network-interface-permission-id  is xml-element      is xml-skip-null is rw;
  has Str $.network-interface-id             is xml-element      is xml-skip-null is rw;
  has Str $.aws-account-id                   is xml-element      is xml-skip-null is rw;
  has Str $.aws-service                      is xml-element      is xml-skip-null is rw;
  has Str $.permission                       is xml-element      is xml-skip-null is rw; #= INSTANCE-ATTACH | EIP-ASSOCIATE
  
  method getValidPermissions {
    %attributes<permissions|ValidValues>.Array
  }
  
  # XXX - get/set attribute methods for status
}

constant NetworkInterfacePermission := Amazon::AWS::EC2::Filters::DescribeNetworkInterfacePermissionsFilter::NetworkInterfacePermission;

class Amazon::AWS::EC2::Filters::DescribeNetworkInterfacePermissionsFilter is export
  does XML::Class[xml-element => 'item']
{
  also does Amazon::AWS::Roles::Base;
  also does Amazon::AWS::Roles::Eqv;
 
  has NetworkInterfacePermission $.network-interface-permission  is xml-skip-null is rw;
} 

# For direct access to any Attribute metadata.
BEGIN {
  %attributes = getAttributeData(
    Amazon::AWS::EC2::Filters::DescribeNetworkInterfacePermissionsFilter::NetworkInterfacePermission
  );
}
