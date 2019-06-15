use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;

use Amazon::AWS::EC2::Types::GroupIdentifier;
use Amazon::AWS::EC2::Types::InstanceIpv6Address;
use Amazon::AWS::EC2::Types::InstanceNetworkInterfaceAssociation;
use Amazon::AWS::EC2::Types::InstanceNetworkInterfaceAttachment;
use Amazon::AWS::EC2::Types::InstancePrivateIpAddress;

class Amazon::AWS::EC2::Types::InstanceNetworkInterface is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has InstanceNetworkInterfaceAssociation    $.association            is xml-element    is xml-skip-null                                                   is rw; 
  has InstanceNetworkInterfaceAttachment     $.attachment             is xml-element    is xml-skip-null                                                   is rw; 
  has Str                                    $.description            is xml-element    is xml-skip-null                                                   is rw; 
  has GroupIdentifier                        @.groups                 is xml-element    is xml-skip-null    is xml-container('groupSet')                   is rw; 
  has Str                                    $.interfaceType          is xml-element    is xml-skip-null                                                   is rw; 
  has InstanceIpv6Address                    @.ipv6Addressess         is xml-element    is xml-skip-null    is xml-container('ipv6AddressesSet')           is rw; 
  has Str                                    $.macAddress             is xml-element    is xml-skip-null                                                   is rw; 
  has Str                                    $.networkInterfaceId     is xml-element    is xml-skip-null                                                   is rw; 
  has Str                                    $.ownerId                is xml-element    is xml-skip-null                                                   is rw; 
  has Str                                    $.privateDnsName         is xml-element    is xml-skip-null                                                   is rw; 
  has Str                                    $.privateIpAddress       is xml-element    is xml-skip-null                                                   is rw; 
  has InstancePrivateIpAddress               @.privateIpAddressess    is xml-element    is xml-skip-null    is xml-container('privateIpAddressesSet')      is rw; 
  has Bool                                   $.sourceDestCheck        is xml-element    is xml-skip-null                                                   is rw; 
  has Str                                    $.status                 is xml-element    is xml-skip-null                                                   is rw;   #=  available | associated | attaching | in-use | detaching
  has Str                                    $.subnetId               is xml-element    is xml-skip-null                                                   is rw; 
  has Str                                    $.vpcId                  is xml-element    is xml-skip-null                                                   is rw; 
}