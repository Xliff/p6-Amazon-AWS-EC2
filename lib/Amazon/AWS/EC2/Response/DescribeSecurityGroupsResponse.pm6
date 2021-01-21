use v6.d;

use XML::Class;

use Amazon::AWS::EC2::Types::SecurityGroup;

use Amazon::AWS::Roles::Response;

our class Amazon::AWS::EC2::Response::DescribeSecurityGroupsResponse is export
  does XML::Class[
    xml-element   => 'DescribeSecurityGroupsResponse',
    xml-namespace => 'http://ec2.amazonaws.com/doc/2016-11-15/'
  ]
{
  also does Amazon::AWS::Roles::Response;

  has Str            $.nextToken is xml-element                     is xml-skip-null                                       is rw;
  has SecurityGroup  @.groups    is xml-element('item', :over-ride) is xml-skip-null is xml-container('securityGroupInfo') is rw;
}
