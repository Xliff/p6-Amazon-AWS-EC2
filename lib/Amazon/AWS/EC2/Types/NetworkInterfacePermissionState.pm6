use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;



class Amazon::AWS::EC2::Types::NetworkInterfacePermissionState is export
  does XML::Class
{
  also is Amazon::AWS::EC2::Types::Base;

  has Str    $.state            is xml-element    is xml-skip-null          is rw;   #=  pending | granted | revoking | revoked
  has Str    $.statusMessage    is xml-element    is xml-skip-null          is rw;
}
