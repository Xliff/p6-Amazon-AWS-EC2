use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;

use Amazon::AWS::EC2::Types::InstanceIpv6Address;
use Amazon::AWS::EC2::Types::PrivateIpAddressSpecification;

class Amazon::AWS::EC2::Types::LaunchTemplateInstanceNetworkInterfaceSpecification is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Bool                             $.associatePublicIpAddress          is xml-element    is xml-skip-null                                                   is rw; 
  has Bool                             $.deleteOnTermination               is xml-element    is xml-skip-null                                                   is rw; 
  has Str                              $.description                       is xml-element    is xml-skip-null                                                   is rw; 
  has Int                              $.deviceIndex                       is xml-element    is xml-skip-null                                                   is rw; 
  has Str                              @.groups                            is xml-element    is xml-skip-null    is xml-container('groupSet')                   is rw; 
  has Str                              $.interfaceType                     is xml-element    is xml-skip-null                                                   is rw; 
  has Int                              $.ipv6AddressCount                  is xml-element    is xml-skip-null                                                   is rw; 
  has InstanceIpv6Address              @.ipv6Addressess                    is xml-element    is xml-skip-null    is xml-container('ipv6AddressesSet')           is rw; 
  has Str                              $.networkInterfaceId                is xml-element    is xml-skip-null                                                   is rw; 
  has Str                              $.privateIpAddress                  is xml-element    is xml-skip-null                                                   is rw; 
  has PrivateIpAddressSpecification    @.privateIpAddressess               is xml-element    is xml-skip-null    is xml-container('privateIpAddressesSet')      is rw; 
  has Int                              $.secondaryPrivateIpAddressCount    is xml-element    is xml-skip-null                                                   is rw; 
  has Str                              $.subnetId                          is xml-element    is xml-skip-null                                                   is rw; 
}