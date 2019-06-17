use v6.d;

use XML::Class;

use Amazon::AWS::Roles::Base;
use Amazon::AWS::Roles::Eqv;

class Amazon::AWS::EC2::Filters::DescribeAddressesFilter::Tag
  does XML::Class[xml-element => 'item']
{
  also does Amazon::AWS::Roles::Base;
  also does Amazon::AWS::Roles::Eqv;

  has Str                 $.key                                         is xml-skip-null is xml-element is rw;
  has Str                 $.value                                       is xml-skip-null is xml-element is rw;
}

constant Tag := Amazon::AWS::EC2::Filters::DescribeAddressesFilter::Tag;

class Amazon::AWS::EC2::Filters::DescribeAddressesFilter is export
  does XML::Class
{
  also does Amazon::AWS::Roles::Base;
  also does Amazon::AWS::Roles::Eqv;

  has Str $.allocation-id                                               is xml-skip-null is xml-element is rw;
  has Str $.association-id                                              is xml-skip-null is xml-element is rw;
  has Str $.domain                                                      is xml-skip-null is xml-element is rw; #=  domain | vpc
  has Str $.network-interface-id                                        is xml-skip-null is xml-element is rw;
  has Str $.network-interface-owner-id                                  is xml-skip-null is xml-element is rw;
  has Str $.private-ip-addrress                                         is xml-skip-null is xml-element is rw;
  has Tag @.tags                          is xml-container('tagSet')    is xml-skip-null                is rw;
  has Str $.tag-key                                                     is xml-skip-null is xml-element is rw;
}
