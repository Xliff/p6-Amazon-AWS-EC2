use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;

use Amazon::AWS::EC2::Types::SubnetIpv6CidrBlockAssociation;
use Amazon::AWS::EC2::Types::Tag;

class Amazon::AWS::EC2::Types::Subnet is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Bool                              $.assignIpv6AddressOnCreation    is xml-element    is xml-skip-null                                                         is rw; 
  has Str                               $.availabilityZone               is xml-element    is xml-skip-null                                                         is rw; 
  has Str                               $.availabilityZoneId             is xml-element    is xml-skip-null                                                         is rw; 
  has Int                               $.availableIpAddressCount        is xml-element    is xml-skip-null                                                         is rw; 
  has Str                               $.cidrBlock                      is xml-element    is xml-skip-null                                                         is rw; 
  has Bool                              $.defaultForAz                   is xml-element    is xml-skip-null                                                         is rw; 
  has SubnetIpv6CidrBlockAssociation    @.ipv6CidrBlockAssociations      is xml-element    is xml-skip-null    is xml-container('ipv6CidrBlockAssociationSet')      is rw; 
  has Bool                              $.mapPublicIpOnLaunch            is xml-element    is xml-skip-null                                                         is rw; 
  has Str                               $.ownerId                        is xml-element    is xml-skip-null                                                         is rw; 
  has Str                               $.state                          is xml-element    is xml-skip-null                                                         is rw;   #=  pending | available
  has Str                               $.subnetArn                      is xml-element    is xml-skip-null                                                         is rw; 
  has Str                               $.subnetId                       is xml-element    is xml-skip-null                                                         is rw; 
  has Tag                               @.tags                           is xml-element    is xml-skip-null    is xml-container('tagSet')                           is rw; 
  has Str                               $.vpcId                          is xml-element    is xml-skip-null                                                         is rw; 
}