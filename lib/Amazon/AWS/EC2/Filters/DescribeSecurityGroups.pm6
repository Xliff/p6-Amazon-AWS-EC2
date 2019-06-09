use v6.d;

use XML::Class;

use Amazon::AWS::EC2::Types::Tag;

class Amazon::AWS::EC2::Filters::DescribeSecurityGroups::IpPermission 
  does XML::Class[xml-element => 'ip-permission']
{
  has Str          $.cidr            is xml-element             is rw;
  has Int          $.from-port       is xml-element             is rw;
  has Str          $.group-id        is xml-element             is rw;
  has Str          $.group-name      is xml-element             is rw;
  has Str          $.ipv6-cidr       is xml-element             is rw;
  has Str          $.prefix-list-id  is xml-element             is rw;
  has Str          $.protocol        is xml-element             is rw; #= tcp | udp | icmp
  has Str          $.to-port         is xml-element             is rw;
  has Str          $.user-id         is xml-element             is rw;
}

constant IpPermission := Amazon::AWS::EC2::Filters::DescribeSecurityGroups::IpPermission;

class Amazon::AWS::EC2::Filters::DescribeSecurityGroups::Filter is export
  does XML::Class[xml-element => 'item']
{
  has Str          $.description     is xml-element             is rw;
  has IpPermission $.egress          is xml-container('egress') is rw;
  has IpPermission $.ip-permission                              is rw;
  has Str          $.group-id        is xml-element             is rw;
  has Str          $.group-name      is xml-element             is rw;
  has Str          $.owner-id        is xml-element             is rw;
  has Str          $.tag-key         is xml-element             is rw;
  has Str          $.vpc-id          is xml-element             is rw;
  has Tag          @.tags            is xml-container('tagSet') is rw;
}
  
