use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;

use Amazon::AWS::EC2::Types::GroupIdentifier;
use Amazon::AWS::EC2::Types::NetworkInterfaceAssociation;
use Amazon::AWS::EC2::Types::NetworkInterfaceAttachment;
use Amazon::AWS::EC2::Types::NetworkInterfaceIpv6Address;
use Amazon::AWS::EC2::Types::NetworkInterfacePrivateIpAddress;
use Amazon::AWS::EC2::Types::Tag;

class Amazon::AWS::EC2::Types::NetworkInterface is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has NetworkInterfaceAssociation         $.association            is xml-element                                                   is rw; 
  has NetworkInterfaceAttachment          $.attachment             is xml-element                                                   is rw; 
  has Str                                 $.availabilityZone       is xml-element                                                   is rw; 
  has Str                                 $.description            is xml-element                                                   is rw; 
  has GroupIdentifier                     @.groups                 is xml-element    is xml-container('groupSet')                   is rw; 
  has Str                                 $.interfaceType          is xml-element                                                   is rw;   #=  interface | natGateway | efa
  has NetworkInterfaceIpv6Address         @.ipv6Addressess         is xml-element    is xml-container('ipv6AddressesSet')           is rw; 
  has Str                                 $.macAddress             is xml-element                                                   is rw; 
  has Str                                 $.networkInterfaceId     is xml-element                                                   is rw; 
  has Str                                 $.ownerId                is xml-element                                                   is rw; 
  has Str                                 $.privateDnsName         is xml-element                                                   is rw; 
  has Str                                 $.privateIpAddress       is xml-element                                                   is rw; 
  has NetworkInterfacePrivateIpAddress    @.privateIpAddressess    is xml-element    is xml-container('privateIpAddressesSet')      is rw; 
  has Str                                 $.requesterId            is xml-element                                                   is rw; 
  has Bool                                $.requesterManaged       is xml-element                                                   is rw; 
  has Bool                                $.sourceDestCheck        is xml-element                                                   is rw; 
  has Str                                 $.status                 is xml-element                                                   is rw;   #=  available | associated | attaching | in-use | detaching
  has Str                                 $.subnetId               is xml-element                                                   is rw; 
  has Tag                                 @.tags                   is xml-element    is xml-container('tagSet')                     is rw; 
  has Str                                 $.vpcId                  is xml-element                                                   is rw; 
}