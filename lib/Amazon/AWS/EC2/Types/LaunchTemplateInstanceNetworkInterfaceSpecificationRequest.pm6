use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;

use Amazon::AWS::EC2::Types::InstanceIpv6AddressRequest;
use Amazon::AWS::EC2::Types::PrivateIpAddressSpecification;

class Amazon::AWS::EC2::Types::LaunchTemplateInstanceNetworkInterfaceSpecificationRequest is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Bool                             $.AssociatePublicIpAddress          is xml-element                        is xml-skip-null                                                is rw;
  has Bool                             $.DeleteOnTermination               is xml-element                        is xml-skip-null                                                is rw;
  has Str                              $.Description                       is xml-element                        is xml-skip-null                                                is rw;
  has Int                              $.DeviceIndex                       is xml-element                        is xml-skip-null                                                is rw;
  has Str                              $.InterfaceType                     is xml-element                        is xml-skip-null                                                is rw;
  has Int                              $.Ipv6AddressCount                  is xml-element                        is xml-skip-null                                                is rw;
  has InstanceIpv6AddressRequest       @.Ipv6Addresses                                                           is xml-skip-null    is xml-container('Ipv6AddressSet')          is rw;
  has Str                              $.NetworkInterfaceId                is xml-element                        is xml-skip-null                                                is rw;
  has Str                              $.PrivateIpAddress                  is xml-element                        is xml-skip-null                                                is rw;
  has PrivateIpAddressSpecification    @.PrivateIpAddresses                is xml-element('item', :over-ride)    is xml-skip-null    is xml-container('PrivateIpAddressSet')     is rw;
  has Int                              $.SecondaryPrivateIpAddressCount    is xml-element                        is xml-skip-null                                                is rw;
  has Str                              @.Groups                            is xml-element('item')                is xml-skip-null    is xml-container('GroupSet')                is rw;
  has Str                              $.SubnetId                          is xml-element                        is xml-skip-null                                                is rw;
}
