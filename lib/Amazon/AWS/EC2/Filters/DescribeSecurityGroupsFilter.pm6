use v6.d;

use Amazon::AWS::Roles::Base;
use Amazon::AWS::Roles::Eqv;

use Amazon::AWS::Utils;

# WTF does this cause t/03-filters.t to fail and ONLY t/03-filters.t!
# use Amazon::AWS::EC2::Types::Tag;

use XML::Class;

my %attributes;

our class Amazon::AWS::EC2::Filters::DescribeSecurityGroupsFilter::Tag
  does XML::Class[xml-element => 'item']
{
  also does Amazon::AWS::Roles::Base;
  also does Amazon::AWS::Roles::Eqv;

  has Str          $.key             is xml-element             is rw;
  has Str          $.value           is xml-element             is rw;
}

our class Amazon::AWS::EC2::Filters::DescribeSecurityGroupsFilter::IpPermission
  does XML::Class
{
  also does Amazon::AWS::Roles::Base;
  also does Amazon::AWS::Roles::Eqv;

  has Str          $.cidr            is xml-element             is rw;
  has Int          $.from-port       is xml-element             is rw;
  has Str          $.group-id        is xml-element             is rw;
  has Str          $.group-name      is xml-element             is rw;
  has Str          $.ipv6-cidr       is xml-element             is rw;
  has Str          $.prefix-list-id  is xml-element             is rw;
  has Str          $.protocol        is xml-element             is rw;  #=  tcp | udp | icmp
  has Str          $.to-port         is xml-element             is rw;
  has Str          $.user-id         is xml-element             is rw;
  
  method getProtocols {
    %attributes<protocol|ValidValues>.Array
  }
}

constant IpPermission := Amazon::AWS::EC2::Filters::DescribeSecurityGroupsFilter::IpPermission;
constant Tag          := Amazon::AWS::EC2::Filters::DescribeSecurityGroupsFilter::Tag;

class Amazon::AWS::EC2::Filters::DescribeSecurityGroupsFilter is export
  does XML::Class
{
  also does Amazon::AWS::Roles::Base;
  also does Amazon::AWS::Roles::Eqv;

  has Str          $.description     is xml-element                                                               is rw;
  has IpPermission $.egress          is xml-element('egress',        :over-ride)                                  is rw;
  has IpPermission $.ip-permission   is xml-element('ip-permission', :over-ride)                                  is rw;
  has Str          $.group-id        is xml-element                                                               is rw;
  has Str          $.group-name      is xml-element                                                               is rw;
  has Str          $.owner-id        is xml-element                                                               is rw;
  has Str          $.tag-key         is xml-element                                                               is rw;
  has Str          $.vpc-id          is xml-element                                                               is rw;
  has Tag          @.tags                                                           is xml-container('tagSet')    is rw;
}

BEGIN {
  %attributes = getAttributeData(
    Amazon::AWS::EC2::Filters::DescribeSecurityGroupsFilter::IpPermission
  );
}
