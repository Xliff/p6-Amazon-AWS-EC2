use v6.c;

use XML::Class;

use Amazon::AWS::Roles::Base;
use Amazon::AWS::Roles::Eqv;

class Amazon::AWS::EC2::Filters::DescribeInstanceTypeOfferingsFilter is export
  does XML::Class[xml-element => 'item']
{
  also does Amazon::AWS::Roles::Base;
  also does Amazon::AWS::Roles::Eqv;

  has Str $.location      is xml-element is xml-skip-null is rw;
  has Str $.instance-type is xml-element is xml-skip-null is rw;
}
