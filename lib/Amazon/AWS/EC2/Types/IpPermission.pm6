use v6.d;

use XML::Class;

use Amazon::AWS::EC2::Types::Base;
use Amazon::AWS::EC2::Types::IpRange;
use Amazon::AWS::EC2::Types::Ipv6Range;
use Amazon::AWS::EC2::Types::PrefixListId;
use Amazon::AWS::EC2::Types::UserIdGroupPair;

class Amazon::AWS::EC2::Types::IpPermission is export
  does XML::Class[xml-element => 'item']
{
  # Does anyone else find this kinda redundant?

  # Request
  has Int             $.FromPort   is xml-element                       is rw;
  has Str             $.IpProtocol is xml-element                       is rw;
  has Int             $.ToPort     is xml-element                       is rw;

  has UserIdGroupPair @.Pairs      is xml-container('UserIdGroupPairs') is rw;
  has IpRange         @.Ranges     is xml-container('IpRanges')         is rw;
  has Ipv6Range       @.V6-Ranges  is xml-container('Ipv6Ranges')       is rw;
  has PrefixListId    @.List-Ids   is xml-container('PrefixListIds')    is rw;

  # Response
  has Int             $.fromPort   is xml-element                       is rw;
  has Str             $.ipProtocol is xml-element                       is rw;
  has Int             $.toPort     is xml-element                       is rw;

  has UserIdGroupPair @.pairs      is xml-container('UserIdGroupPairs') is rw;
  has IpRange         @.ranges     is xml-container('IpRanges')         is rw;
  has Ipv6Range       @.v6-ranges  is xml-container('Ipv6Ranges')       is rw;
  has PrefixListId    @.list-ids   is xml-container('PrefixListIds')    is rw;

}
