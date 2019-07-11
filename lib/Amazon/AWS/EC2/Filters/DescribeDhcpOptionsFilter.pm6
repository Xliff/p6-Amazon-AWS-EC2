use v6.d;

use Amazon::AWS::Roles::Base;
use Amazon::AWS::Roles::Eqv;

use XML::Class;

class Amazon::AWS::EC2::Filters::DescribeDhcpOptionsFilter::Tag
  does XML::Class[xml-element => 'item']
{
  also does Amazon::AWS::Roles::Base;
  also does Amazon::AWS::Roles::Eqv;

  has Str    $.key      is xml-element is xml-skip-null is rw;
  has Str    $.value    is xml-element is xml-skip-null is rw;
}

constant Tag := Amazon::AWS::EC2::Filters::DescribeDhcpOptionsFilter::Tag;

class Amazon::AWS::EC2::Filters::DescribeDhcpOptionsFilter is export
  does XML::Class[xml-element => 'item']
{
  also does Amazon::AWS::Roles::Base;
  also does Amazon::AWS::Roles::Eqv;
  
  has Str  $.dhcp-option-id                     is xml-element is xml-skip-null is rw;
  has Str  $.key                                is xml-element is xml-skip-null is rw;
  has Str  $.value                              is xml-element is xml-skip-null is rw;
  has Str  $.name                               is xml-element is xml-skip-null is rw;
  has Str  $.owner-id                           is xml-element is xml-skip-null is rw;
  has Tag  @.tags is xml-container('tagSet')                   is xml-skip-null is rw;
  has Str  $.tag-key                            is xml-element is xml-skip-null is rw
} 
