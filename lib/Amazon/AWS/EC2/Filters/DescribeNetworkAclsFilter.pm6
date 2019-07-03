use v6.d;

use XML::Class;

use Amazon::AWS::Roles::Base;
use Amazon::AWS::Roles::Eqv;

use Amazon::AWS::Utils;

my %attributes;

class Amazon::AWS::EC2::Filters::DescribeNetworkAclsFilter::Association
  does XML::Class[xml-element => 'association']
{
  also does Amazon::AWS::Roles::Base;
  also does Amazon::AWS::Roles::Eqv;

  has Str                       $.association-id          is xml-element is xml-skip-null is rw;
  has Str                       $.network-acl-id          is xml-element is xml-skip-null is rw;
  has Str                       $.subnet-id               is xml-element is xml-skip-null is rw;
}

class Amazon::AWS::EC2::Filters::DescribeNetworkAclsFilter::Icmp
  does XML::Class[xml-element => 'icmp']
{
  also does Amazon::AWS::Roles::Base;
  also does Amazon::AWS::Roles::Eqv;

  has Str                       $.code        is xml-element is xml-skip-null is rw;
  has Str                       $.type        is xml-element is xml-skip-null is rw;
}

class Amazon::AWS::EC2::Filters::DescribeNetworkAclsFilter::Port-Range
  does XML::Class[xml-element => 'port-range']
{
  also does Amazon::AWS::Roles::Base;
  also does Amazon::AWS::Roles::Eqv;

  has Int                       $.from        is xml-element is xml-skip-null is rw;
  has Int                       $.to          is xml-element is xml-skip-null is rw;
}

class Amazon::AWS::EC2::Filters::DescribeNetworkAclsFilter::Tag
  does XML::Class[xml-element => 'item']
{
  also does Amazon::AWS::Roles::Base;
  also does Amazon::AWS::Roles::Eqv;

  has Str                       $.key                       is xml-element is xml-skip-null is rw;
  has Str                       $.value                     is xml-element is xml-skip-null is rw;
}

class Amazon::AWS::EC2::Filters::DescribeNetworkAclsFilter::Entry { ... }

constant Entry       := Amazon::AWS::EC2::Filters::DescribeNetworkAclsFilter::Entry;
constant Icmp        := Amazon::AWS::EC2::Filters::DescribeNetworkAclsFilter::Icmp;
constant Port-Range  := Amazon::AWS::EC2::Filters::DescribeNetworkAclsFilter::Port-Range;
constant Association := Amazon::AWS::EC2::Filters::DescribeNetworkAclsFilter::Association;
constant Tag         := Amazon::AWS::EC2::Filters::DescribeNetworkAclsFilter::Tag;

class Amazon::AWS::EC2::Filters::DescribeNetworkAclsFilter::Entry
  does XML::Class[xml-element => 'entry']
{
  also does Amazon::AWS::Roles::Base;
  also does Amazon::AWS::Roles::Eqv;

  has Str                       $.cidr         is xml-element is xml-skip-null is rw;
  has Icmp                      $.icmp                        is xml-skip-null is rw;
  has Str                       $.ipv6-cidr    is xml-element is xml-skip-null is rw;
  has Port-Range                $.port-range                  is xml-skip-null is rw;
  has Str                       $.protocol     is xml-element is xml-skip-null is rw;   #= regex:tcp | udp | icmp | \d+
  has Str                       $.rule-action  is xml-element is xml-skip-null is rw;   #=  allow | deny
  has Int                       $.rule-number  is xml-element is xml-skip-null is rw;
}

# All objects used are local objects. Any EC2 objects used shall be fully qualified.
class Amazon::AWS::EC2::Filters::DescribeNetworkAclsFilter is export
  does XML::Class
{
  also does Amazon::AWS::Roles::Base;
  also does Amazon::AWS::Roles::Eqv;

  has Association $.association                                                     is xml-skip-null is rw;
  has Str         $.default                                          is xml-element is xml-skip-null is rw;
  has Entry       $.entry                                                           is xml-skip-null is rw;
  has Str         $.network-acl-id                                   is xml-element is xml-skip-null is rw;
  has Str         $.owner-id                                         is xml-element is xml-skip-null is rw;
  has Tag         @.tags                is xml-container('tagSet')                  is xml-skip-null is rw;
  has Str         $.tag-key                                          is xml-element is xml-skip-null is rw;
  has Str         $.vpc-id                                           is xml-element is xml-skip-null is rw;
}

BEGIN {
  %attributes<Entry> = getAttributeData(
    Amazon::AWS::EC2::Filters::DescribeNetworkAclsFilter::Entry
  );
}
