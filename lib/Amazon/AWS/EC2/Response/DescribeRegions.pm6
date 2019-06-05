use v6.d;

use XML::Class;

class Amazon::AWS::EC2::Response::DescribeRegions
  does XML::Class[
    xml-element   => 'DescribeRegionsResponse',
    xml-namespace => 'http://ec2.amazonaws.com/doc/2013-10-15/'
  ]
{

  class RegionInfo
    does XML::Class[xml-element => 'regionInfo']
  {
    class RegionItem does XML::Class[xml-element => 'item'] {
      has $.regionName     is xml-element;
      has $.regionEndpoint is xml-element;
    }

    has RegionItem @.items;
  }

  has $.requestId is xml-element;
  has RegionInfo $.regionInfo
}
