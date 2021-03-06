use v6.d;

use XML::Class;

use Amazon::AWS::EC2::Types::Region;

use Amazon::AWS::Roles::Response;

class Amazon::AWS::EC2::Response::DescribeRegionsResponse is export
  does XML::Class[
    xml-element   => 'DescribeRegionsResponse',
    xml-namespace => 'http://ec2.amazonaws.com/doc/2013-10-15/'
  ]
{
  also does Amazon::AWS::Roles::Response;

  has Region     @.regions is xml-container('regionInfo') is xml-skip-null is rw;
}
