use v6.d;

use XML::Class;

use Amazon::AWS::Roles::Response;
use Amazon::AWS::EC2::Region;

class Amazon::AWS::EC2::Response::DescribeRegions is export
  does XML::Class[
    xml-element   => 'DescribeRegionsResponse',
    xml-namespace => 'http://ec2.amazonaws.com/doc/2013-10-15/'
  ]
{
  also does Amazon::AWS::Roles::Response;

  has Region     @.items is xml-container('regionInfo');
}
