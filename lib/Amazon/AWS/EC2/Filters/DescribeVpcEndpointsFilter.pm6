use v6.d;

use XML::Class;

use Amazon::AWS::Roles::Base;
use Amazon::AWS::Roles::Eqv;

class Amazon::AWS::EC2::Filters::DescribeVpcEndpointsFilter::Tag
  does XML::Class[xml-element => 'item']
{
  also does Amazon::AWS::Roles::Base;
  also does Amazon::AWS::Roles::Eqv;

  has Str                 $.key                                         is xml-skip-null is xml-element is rw;
  has Str                 $.value                                       is xml-skip-null is xml-element is rw;
}

constant Tag := Amazon::AWS::EC2::Filters::DescribeVpcEndpointsFilter::Tag;

class Amazon::AWS::EC2::Filters::DescribeVpcEndpointsFilter is export
  does XML::Class
{
  also does Amazon::AWS::Roles::Base;
  also does Amazon::AWS::Roles::Eqv;

  has Str $.service-name                                      is xml-skip-null is xml-element is rw;
  has Str $.vpc-id                                            is xml-skip-null is xml-element is rw;
  has Str $.vpc-endpoint-id                                   is xml-skip-null is xml-element is rw;
  has Str $.vpc-endpoint-state                                is xml-skip-null is xml-element is rw;  #=  pending | available | deleting | deleted
  has Tag @.tags                is xml-container('tagSet')    is xml-skip-null                is rw;
  has Str $.tag-key                                           is xml-skip-null is xml-element is rw;
}
