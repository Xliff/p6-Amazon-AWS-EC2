use v6.d;

use Amazon::AWS::Roles::Base;
use Amazon::AWS::Roles::Eqv;

use Amazon::AWS::Utils;

use XML::Class;

my %attributes;

class Amazon::AWS::EC2::Filters::DescribeVpcsFilter::Association
  does XML::Class
{
  has Str $.association-id            is xml-element is xml-skip-null is rw;
  has Str $.cidr-block                is xml-element is xml-skip-null is rw;
  has Str $.state                     is xml-element is xml-skip-null is rw;
}

class Amazon::AWS::EC2::Filters::DescribeVpcsFilter::Tag
  does XML::Class[xml-element => 'item']
{
  also does Amazon::AWS::Roles::Base;
  also does Amazon::AWS::Roles::Eqv;

  has Str $.key                       is xml-element is xml-skip-null is rw;
  has Str $.value                     is xml-element is xml-skip-null is rw;
}

constant Association := Amazon::AWS::EC2::Filters::DescribeVpcsFilter::Association;
constant Tag         := Amazon::AWS::EC2::Filters::DescribeVpcsFilter::Tag;

class Amazon::AWS::EC2::Filters::DescribeVpcsFilter is export
  does XML::Class[xml-element => 'item']
{
  also does Amazon::AWS::Roles::Base;
  also does Amazon::AWS::Roles::Eqv;
 
  has Str         $.cidr                                                     is xml-element                                             is xml-skip-null is rw;
  has Association $.cidr-block-association                                   is xml-element('cidr-block-association',      :over-ride)  is xml-skip-null is rw;
  has Association $.ipv6-cidr-block-association                              is xml-element('ipv6-cidr-block-association', :over-ride)  is xml-skip-null is rw;
  has Bool        $.isDefault                                                is xml-element                                             is xml-skip-null is rw;
  has Str         $.owner-id                                                 is xml-element                                             is xml-skip-null is rw;  
  has Str         $.state                                                    is xml-element                                             is xml-skip-null is rw;  #= pending | available
  has Tag         @.tags                         is xml-container('tagSet')                                                             is xml-skip-null is rw;
  has Str         $.tag-key                                                  is xml-element                                             is xml-skip-null is rw;  
  has Str         $.vpc-id                                                   is xml-element                                             is xml-skip-null is rw;
  
  method getValidStates {
    %attributes<States|ValidValues>.Array
  }
  
  # XXX - get/set attribute methods for status
} 

# For direct access to any Attribute metadata.
BEGIN {
  %attributes = getAttributeData(
    Amazon::AWS::EC2::Filters::DescribeVpcsFilter
  );
}
