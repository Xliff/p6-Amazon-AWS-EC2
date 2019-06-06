use v6.d;

use Amazon::AWS::EC2::Base;

use XML::Class;

use Amazon::AWS::EC2::InstanceNetworkInterfaceAssociation;

class Amazon::AWS::EC2::InstancePrivateIpAddress is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Base;

  has InstanceNetworkInterfaceAssociation $.association                     is rw;
  has Bool                                $.primary          is xml-element is rw;
  has Str                                 $.privateDnsName   is xml-element is rw;
  has Str                                 $.privateIpAddress is xml-element is rw;
}