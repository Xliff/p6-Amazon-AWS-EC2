use v6.d;

use Amazon::AWS::Roles::Response;

use XML::Class;

use Amazon::AWS::EC2::Types::InstanceMonitoring;

class Amazon::AWS::EC2::Response::UnmonitorInstancesResponse is export
  does XML::Class[xml-element => 'item']
{
  also does Amazon::AWS::Roles::Response;

  has InstanceMonitoring    @.instancess    is xml-element    is xml-container('instancesSet')      is rw; 
}