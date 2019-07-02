use v6.d;

use XML::Class;

use Amazon::AWS::Roles::Base;
use Amazon::AWS::Roles::Eqv;

use Amazon::AWS::Utils;

my %attributes;

class Amazon::AWS::EC2::Filters::DescribeSubnetsFilter::Ipv6CidrBlockAssociation 
  does XML::Class[xml-element => 'ipv6-cidr-block-assiciation']
{
  has Str $.ipv6-cidr-block                                            is xml-skip-null is xml-element is rw;
  has Str $.association-id                                             is xml-skip-null is xml-element is rw;
  has Str $.state                                                      is xml-skip-null is xml-element is rw; 
}
  
class Amazon::AWS::EC2::Filters::DescribeSubnetsFilter::Tag
  does XML::Class[xml-element => 'item']
{
  also does Amazon::AWS::Roles::Base;
  also does Amazon::AWS::Roles::Eqv;
  has Str                 $.key                                        is xml-skip-null is xml-element is rw;
  has Str                 $.value                                      is xml-skip-null is xml-element is rw;
}

constant Ipv6CidrBlockAssociation := Amazon::AWS::EC2::Filters::DescribeSubnetsFilter::Ipv6CidrBlockAssociation;
constant Tag                      := Amazon::AWS::EC2::Filters::DescribeSubnetsFilter::Tag;

class Amazon::AWS::EC2::Filters::DescribeSubnetsFilter is export
  does XML::Class[xml-element => 'DescribeSubnetsFilter']
{
  also does Amazon::AWS::Roles::Base;
  also does Amazon::AWS::Roles::Eqv;

  has Str                      $.availability-zone                                          is xml-skip-null is xml-element is rw;
  has Str                      $.availability-zone-id                                       is xml-skip-null is xml-element is rw;
  has Str                      $.availabile-ip-address-count                                is xml-skip-null is xml-element is rw;
  has Str                      $.cidr-block                                                 is xml-skip-null is xml-element is rw;
  has Str                      $.default-for-az                                             is xml-skip-null is xml-element is rw;
  has Ipv6CidrBlockAssociation $.ipv6-cidr-block-association                                is xml-skip-null                is rw;
  has Str                      $.owner-id                                                   is xml-skip-null is xml-element is rw;
  has Str                      $.state                                                      is xml-skip-null is xml-element is rw;  #=  pending | available
  has Str                      $.subnet-arn                                                 is xml-skip-null is xml-element is rw;
  has Str                      $.subnet-id                                                  is xml-skip-null is xml-element is rw;
  has Tag                      @.tags                           is xml-container('tagSet')  is xml-skip-null                is rw;
  has Str                      $.tag-key                                                    is xml-skip-null is xml-element is rw;
  has Str                      $.vpc-id                                                     is xml-skip-null is xml-element is rw;
  
  method getValidStates {
    %attributes<States|ValidValues>.Array;
  }
}

BEGIN {
  %attributes = getAttributeData(
    Amazon::AWS::EC2::Filters::DescribeSubnetsFilter
  )
}
