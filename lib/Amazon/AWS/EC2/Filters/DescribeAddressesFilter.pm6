use v6.d;

use XML::Class;

use Amazon::AWS::Roles::Base;

class Amazon::AWS::EC2::Filters::DescribeAddressesFilter::Tag
  does XML::Class[xml-element => 'item']
{
  also does Amazon::AWS::Roles::Base;

  has Str                 $.key                                                 is xml-element   is rw;
  has Str                 $.value                                               is xml-element   is rw;
}

constant Tag := Amazon::AWS::EC2::Filters::DescribeAddressesFilter::Tag;

class Amazon::AWS::EC2::Filters::DescribeAddressesFilter is export
  does XML::Class[xml-element => 'item']
{
  also does Amazon::AWS::Roles::Base;

  has Str $.allocation-id                                               is xml-element is rw;
  has Str $.association-id                                              is xml-element is rw;
  has Str $.domain                                                      is xml-element is rw; #=  domain | vpc
  has Str $.network-interface-id                                        is xml-element is rw;
  has Str $.network-interface-owner-id                                  is xml-element is rw;
  has Str $.private-ip-addrress                                         is xml-element is rw;
  has Tag @.tags                          is xml-container('tagSet')                   is rw;
  has Str $.tag-key                                                     is xml-element is rw;
}
