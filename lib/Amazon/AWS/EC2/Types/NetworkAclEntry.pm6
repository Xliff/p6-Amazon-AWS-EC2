use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;

use Amazon::AWS::EC2::Types::IcmpTypeCode;
use Amazon::AWS::EC2::Types::PortRange;

class Amazon::AWS::EC2::Types::NetworkAclEntry is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Str             $.cidrBlock        is xml-element                is xml-skip-null          is rw; 
  has Bool            $.egress           is xml-element                is xml-skip-null          is rw; 
  has IcmpTypeCode    $.icmpTypeCode     is xml-element(:over-ride)    is xml-skip-null          is rw;
  has Str             $.ipv6CidrBlock    is xml-element                is xml-skip-null          is rw;
  has PortRange       $.portRange        is xml-element(:over-ride)    is xml-skip-null          is rw;
  has Str             $.protocol         is xml-element                is xml-skip-null          is rw;
  has Str             $.ruleAction       is xml-element                is xml-skip-null          is rw;   #=  allow | deny
  has Int             $.ruleNumber       is xml-element                is xml-skip-null          is rw;
}
