use v6.d;

use Amazon::AWS::Roles::Request;
use Amazon::AWS::EC2::InstanceStateChange;

class Amazon::AWS::EC2::Response::StartInstances {
  does XML::Class[
    xml-element   => 'DescribeRegionsResponse',
    xml-namespace => 'http://ec2.amazonaws.com/doc/2016-11-15/'
  ]
{
  class InstancesSet is XML::Class[xml-element => 'instancesSet'] {
    has InstanceStateChange @.item;
  }

  has InstanceStateChange $.instancesSet;
}
