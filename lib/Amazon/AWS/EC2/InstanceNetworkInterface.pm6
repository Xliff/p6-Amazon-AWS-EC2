use v6.d;

use Amazon::AWS::EC2::GroupIdentifier;
use Amazon::AWS::EC2::InstanceNetworkInterfaceAssociation;
use Amazon::AWS::EC2::InstanceNetworkInterfaceAttachment;
use Amazon::AWS::EC2::InstancePrivateIpAddress;

use XML::Class;

class Amazon::AWS::EC2::InstanceNetworkInterface is export
  does XML::Class[xml-element => 'item']
{
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

  has GroupIdentifier          @.groups             is xml-container('groupSet');
  has InstancePrivateIpAddress @.privateIpAddresses is xml-container('privateIpAddressesSet');
}
