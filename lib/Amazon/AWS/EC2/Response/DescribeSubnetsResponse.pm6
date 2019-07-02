use v6.d;

use Amazon::AWS::Roles::Response;

use XML::Class;

use Amazon::AWS::EC2::Types::Subnet;

class Amazon::AWS::EC2::Response::DescribeSubnetsResponse is export
  does XML::Class[xml-element => 'DescribeSubnetsResponse']
{
  also does Amazon::AWS::Roles::Response;

  has Str       $.nextToken    is xml-element                                                     is xml-skip-null is rw;
  has Subnet    @.tags         is xml-element('item', :over-ride)  is xml-container('subnetSet')  is xml-skip-null is rw;
}
