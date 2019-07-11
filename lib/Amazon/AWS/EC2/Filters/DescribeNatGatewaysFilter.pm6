use v6.d;

use XML::Class;

use Amazon::AWS::Roles::Base;
use Amazon::AWS::Roles::Eqv;

use Amazon::AWS::Utils;

my %attributes;

class Amazon::AWS::EC2::Filters::DescribeNatGatewaysFilter::Tag
  does XML::Class[xml-element => 'item']
{
  also does Amazon::AWS::Roles::Base;
  also does Amazon::AWS::Roles::Eqv;

  has Str                 $.key                                         is xml-skip-null is xml-element is rw;
  has Str                 $.value                                       is xml-skip-null is xml-element is rw;
}

constant Tag := Amazon::AWS::EC2::Filters::DescribeNatGatewaysFilter::Tag;

class Amazon::AWS::EC2::Filters::DescribeNatGatewaysFilter is export
  does XML::Class[xml-element => 'item']
{
  also does Amazon::AWS::Roles::Base;
  also does Amazon::AWS::Roles::Eqv;

  has Str $.nat-gateway-id                                              is xml-skip-null is xml-element is rw;
  has Str $.state                                                       is xml-skip-null is xml-element is rw;           #=  pending | failed | available | deleting | deleted
  has Str $.subnet-id                                                   is xml-skip-null is xml-element is rw;
  has Tag @.tags                          is xml-container('tagSet')    is xml-skip-null                is rw;
  has Str $.tag-key                                                     is xml-skip-null is xml-element is rw;
  has Str $.vpc-id                                                      is xml-skip-null is xml-element is rw;
  
  method getValidStates {
    %attributes<states|ValidValues>.Array;
  }
  
}

BEGIN {
  %attributes = getAttributeData(
    Amazon::AWS::EC2::Filters::DescribeNatGatewaysFilter
  );
}
