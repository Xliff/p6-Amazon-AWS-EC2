use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;

class Amazon::AWS::EC2::Types::DescribeInstanceTypeOfferings is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Str    $.instanceType    is xml-element    is xml-skip-null          is rw;   #= validation:Amazon::AWS::EC2::validInstanceTypes::checkInstanceType
  has Str    $.location        is xml-element    is xml-skip-null          is rw;
  has Str    $.locationType    is xml-element    is xml-skip-null          is rw;   #= region | availability-zone | availability-zone-id
}
