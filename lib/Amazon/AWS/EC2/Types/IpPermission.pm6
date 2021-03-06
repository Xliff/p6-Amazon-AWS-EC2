use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;

use Amazon::AWS::EC2::Types::IpRange;
use Amazon::AWS::EC2::Types::Ipv6Range;
use Amazon::AWS::EC2::Types::PrefixListId;
use Amazon::AWS::EC2::Types::UserIdGroupPair;

class Amazon::AWS::EC2::Types::IpPermission is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Int                $.FromPort            is xml-element                        is xml-skip-null                                              is rw;
  has Int                $.fromPort            is xml-element                        is xml-skip-null                                              is rw;
  has UserIdGroupPair    @.UserIdGroupPairs    is xml-element('item', :over-ride)    is xml-skip-null    is xml-container('userIdGroupPairs')      is rw;
  has UserIdGroupPair    @.userIdGroupPairs    is xml-element('item', :over-ride)    is xml-skip-null    is xml-container('userIdGroupPairs')      is rw;
  has UserIdGroupPair    @.groups              is xml-element('item', :over-ride)    is xml-skip-null    is xml-container('groups')                is rw;
  has UserIdGroupPair    @.Groups              is xml-element('item', :over-ride)    is xml-skip-null    is xml-container('groups')                is rw;
  has Str                $.IpProtocol          is xml-element                        is xml-skip-null                                              is rw;
  has Str                $.ipProtocol          is xml-element                        is xml-skip-null                                              is rw;
  has IpRange            @.IpRanges            is xml-element('item', :over-ride)    is xml-skip-null    is xml-container('IpRanges')              is rw;
  has IpRange            @.ipRanges            is xml-element('item', :over-ride)    is xml-skip-null    is xml-container('ipRanges')              is rw;
  has Ipv6Range          @.Ipv6Ranges          is xml-element('item', :over-ride)    is xml-skip-null    is xml-container('Ipv6Range')             is rw;
  has Ipv6Range          @.ipv6Ranges          is xml-element('item', :over-ride)    is xml-skip-null    is xml-container('ipv6Range')             is rw;
  has PrefixListId       @.PrefixListIds       is xml-element('item', :over-ride)    is xml-skip-null    is xml-container('PrefixListIds')         is rw;
  has PrefixListId       @.prefixListIds       is xml-element('item', :over-ride)    is xml-skip-null    is xml-container('prefixListIds')         is rw;
  has Int                $.ToPort              is xml-element                        is xml-skip-null                                              is rw;
  has Int                $.toPort              is xml-element                        is xml-skip-null                                              is rw;
}
