use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;

use Amazon::AWS::EC2::Types::NetworkInterfacePermissionState;

class Amazon::AWS::EC2::Types::NetworkInterfacePermission is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Str                                $.awsAccountId                    is xml-element                is xml-skip-null          is rw; 
  has Str                                $.awsService                      is xml-element                is xml-skip-null          is rw; 
  has Str                                $.networkInterfaceId              is xml-element                is xml-skip-null          is rw; 
  has Str                                $.networkInterfacePermissionId    is xml-element                is xml-skip-null          is rw; 
  has Str                                $.permission                      is xml-element                is xml-skip-null          is rw;   #=  INSTANCE-ATTACH | EIP-ASSOCIATE
  has NetworkInterfacePermissionState    $.permissionState                 is xml-element(:over-ride)    is xml-skip-null          is rw;
}
