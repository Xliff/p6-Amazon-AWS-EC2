use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;

use Amazon::AWS::EC2::Types::CidrBlock;
use Amazon::AWS::EC2::Types::Ipv6CidrBlock;
use Amazon::AWS::EC2::Types::VpcPeeringConnectionOptionsDescription;

class Amazon::AWS::EC2::Types::VpcPeeringConnectionVpcInfo is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Str                                       $.cidrBlock         is xml-element                        is xml-skip-null                                              is rw;
  has CidrBlock                                 @.cidrBlocks        is xml-element('item', :over-ride)    is xml-skip-null    is xml-container('cidrBlockSet')          is rw;
  has Ipv6CidrBlock                             @.ipv6CidrBlocks    is xml-element('item', :over-ride)    is xml-skip-null    is xml-container('ipv6CidrBlockSet')      is rw;
  has Str                                       $.ownerId           is xml-element                        is xml-skip-null                                              is rw;
  has VpcPeeringConnectionOptionsDescription    $.peeringOptions    is xml-element(        :over-ride)    is xml-skip-null                                              is rw;
  has Str                                       $.region            is xml-element                        is xml-skip-null                                              is rw;
  has Str                                       $.vpcId             is xml-element                        is xml-skip-null                                              is rw;
}
