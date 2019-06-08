use v6.d;

use Amazon::AWS::EC2::Types::Base;

use Amazon::AWS::EC2::Types::GroupIdentifier;
use Amazon::AWS::EC2::Types::InstanceNetworkInterfaceAssociation;
use Amazon::AWS::EC2::Types::InstanceNetworkInterfaceAttachment;
use Amazon::AWS::EC2::Types::InstancePrivateIpAddress;

use XML::Class;

class Amazon::AWS::EC2::Types::InstanceNetworkInterface is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has InstanceNetworkInterfaceAssociation $.association                       is rw;
  has InstanceNetworkInterfaceAttachment  $.attachment                        is rw;
  has Str                                 $.description        is xml-element is rw;
  has Str                                 $.interfaceType      is xml-element is rw;
  has Str                                 $.macAddress         is xml-element is rw;
  has Str                                 $.networkInterfaceId is xml-element is rw;
  has Str                                 $.privateDnsName     is xml-element is rw;
  has Str                                 $.privateIpAddress   is xml-element is rw;
  has Bool                                $.sourceDestCheck    is xml-element is rw;
  has Str                                 $.status             is xml-element is rw;
  has Str                                 $.subnetId           is xml-element is rw;

  has GroupIdentifier          @.groups
    is xml-container('groupSet')                                              is rw;
  has InstancePrivateIpAddress @.privateIpAddresses is
    xml-container('privateIpAddressesSet')                                    is rw;
}
