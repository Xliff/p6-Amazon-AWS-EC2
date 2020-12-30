use v6.d;

use Amazon::AWS::Roles::Response;

use XML::Class;

use Amazon::AWS::EC2::Types::InstanceStateChange;

class Amazon::AWS::EC2::Response::TerminateInstancesResponse is export
  does XML::Class[xml-element => 'TerminateInstancesResponse']
{
  also does Amazon::AWS::Roles::Response;

  has InstanceStateChange  @.instances  is xml-element('item', :over-ride)  is xml-skip-null  is xml-container('instancesSet')  is rw;
}
