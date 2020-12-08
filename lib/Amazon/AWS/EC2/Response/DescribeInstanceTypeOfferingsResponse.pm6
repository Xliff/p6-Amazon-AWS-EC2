use v6.d;

use Amazon::AWS::Roles::Response;

use XML::Class;

use Amazon::AWS::EC2::Types::DescribeInstanceTypeOfferings;

class Amazon::AWS::EC2::Response::DescribeInstanceTypeOfferingsResponse is export
  does XML::Class[xml-element => 'item']
{
  also does Amazon::AWS::Roles::Response;

  has DescribeInstanceTypeOfferings @.instanceTypeOfferings                    is xml-skip-null    is xml-container('instanceTypeOfferingSet')  is rw;
  has Str                           $.nextToken                is xml-element  is xml-skip-null                                                 is rw;
}
