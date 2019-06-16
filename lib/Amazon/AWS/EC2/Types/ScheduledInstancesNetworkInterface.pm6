use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;

use Amazon::AWS::EC2::Types::ScheduledInstancesIpv6Address;
use Amazon::AWS::EC2::Types::ScheduledInstancesPrivateIpAddressConfig;

class Amazon::AWS::EC2::Types::ScheduledInstancesNetworkInterface is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Bool                                        $.AssociatePublicIpAddress          is xml-element            is xml-skip-null                                                     is rw;
  has Bool                                        $.DeleteOnTermination               is xml-element            is xml-skip-null                                                     is rw;
  has Str                                         $.Description                       is xml-element            is xml-skip-null                                                     is rw;
  has Int                                         $.DeviceIndex                       is xml-element            is xml-skip-null                                                     is rw;
  has Str                                         @.Groups                            is xml-element('item')    is xml-skip-null    is xml-container('Groups')                       is rw;
  has ScheduledInstancesIpv6Address               @.Ipv6Addresses                                               is xml-skip-null    is xml-container('Ipv6Addresses')                is rw;
  has Int                                         $.Ipv6AddressCount                  is xml-element            is xml-skip-null                                                     is rw;
  has Str                                         $.NetworkInterfaceId                is xml-element            is xml-skip-null                                                     is rw;
  has Str                                         $.PrivateIpAddress                  is xml-element            is xml-skip-null                                                     is rw;
  has ScheduledInstancesPrivateIpAddressConfig    @.PrivateIpAddressConfigs                                     is xml-skip-null    is xml-container('PrivateIpAddressConfigs')      is rw;
  has Int                                         $.SecondaryPrivateIpAddressCount    is xml-element            is xml-skip-null                                                     is rw;
  has Str                                         $.SubnetId                          is xml-element            is xml-skip-null                                                     is rw;
}
