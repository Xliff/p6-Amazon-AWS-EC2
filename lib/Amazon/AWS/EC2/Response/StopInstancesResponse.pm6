use v6.d;

use XML::Class;

use Amazon::AWS::EC2::Types::InstanceStateChange;

use Amazon::AWS::Roles::Response;

class Amazon::AWS::EC2::Response::StopInstancesResponse is export
  does XML::Class[
    xml-element   => 'StopInstancesResponse',
    xml-namespace => 'http://ec2.amazonaws.com/doc/2016-11-15/'
  ]
{
  also does Amazon::AWS::Roles::Response;

  has InstanceStateChange @.instance-states is xml-container('instancesSet') is rw;
}
