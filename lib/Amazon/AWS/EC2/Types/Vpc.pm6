use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;

use Amazon::AWS::EC2::Types::Tag;
use Amazon::AWS::EC2::Types::VpcCidrBlockAssociation;
use Amazon::AWS::EC2::Types::VpcIpv6CidrBlockAssociation;

class Amazon::AWS::EC2::Types::Vpc is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Str                            $.cidrBlock                    is xml-element    is xml-skip-null                                                         is rw;
  has VpcCidrBlockAssociation        @.cidrBlockAssociations        is xml-element    is xml-skip-null    is xml-container('cidrBlockAssociationSet')          is rw;
  has Str                            $.dhcpOptionsId                is xml-element    is xml-skip-null                                                         is rw;
  has Str                            $.instanceTenancy              is xml-element    is xml-skip-null                                                         is rw;   #=  default | dedicated | host
  has VpcIpv6CidrBlockAssociation    @.ipv6CidrBlockAssociations    is xml-element    is xml-skip-null    is xml-container('ipv6CidrBlockAssociationSet')      is rw;
  has Bool                           $.isDefault                    is xml-element    is xml-skip-null                                                         is rw;
  has Str                            $.ownerId                      is xml-element    is xml-skip-null                                                         is rw;
  has Str                            $.state                        is xml-element    is xml-skip-null                                                         is rw;   #=  pending | available
  has Tag                            @.tags                                           is xml-skip-null    is xml-container('tagSet')                           is rw; 
  has Str                            $.vpcId                        is xml-element    is xml-skip-null                                                         is rw;
}
