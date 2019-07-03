use v6.d;

use Amazon::AWS::Roles::Base;
use Amazon::AWS::Roles::Eqv;

use Amazon::AWS::Utils;

use XML::Class;

class Amazon::AWS::EC2::Filters::DescribeInternetGatewaysFilter::Attachment
  does XML::Class[xml-element => 'attachment']
{
  has Str $.state                        is xml-element is xml-skip-null is rw;
  has Str $.vpc-id                       is xml-element is xml-skip-null is rw;
}

class Amazon::AWS::EC2::Filters::DescribeInternetGatewaysFilter::Tag
  does XML::Class[xml-element => 'item']
{
  also does Amazon::AWS::Roles::Base;
  also does Amazon::AWS::Roles::Eqv;

  has Str $.key                          is xml-element is xml-skip-null is rw;
  has Str $.value                        is xml-element is xml-skip-null is rw;
}

constant Attachment := Amazon::AWS::EC2::Filters::DescribeInternetGatewaysFilter::Attachment;
constant Tag        := Amazon::AWS::EC2::Filters::DescribeInternetGatewaysFilter::Tag;

class Amazon::AWS::EC2::Filters::DescribeInternetGatewaysFilter is export
  does XML::Class[xml-element => 'item']
{
  also does Amazon::AWS::Roles::Base;
  also does Amazon::AWS::Roles::Eqv;
 
  has Attachment  $.attachment                                                       is xml-skip-null is rw;
  has Str         $.internet-gateway-id                              is xml-element  is xml-skip-null is rw;  
  has Str         $.owner-id                                         is xml-element  is xml-skip-null is rw;
  has Tag         @.tags                 is xml-container('tagSet')                  is xml-skip-null is rw;
  has Str         $.tag-key                                          is xml-element  is xml-skip-null is rw; 
  
  # XXX - get/set attribute methods for status
} 
