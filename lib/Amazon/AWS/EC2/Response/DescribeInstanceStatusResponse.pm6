use v6.d;

use Amazon::AWS::Roles::Response;

use XML::Class;

use Amazon::AWS::EC2::Types::InstanceStatus;

class Amazon::AWS::EC2::Response::DescribeInstanceStatusResponse is export
  does XML::Class[xml-element => 'item']
{
  also does Amazon::AWS::Roles::Response;

  has InstanceStatus    @.instanceStatuss    is xml-element    is xml-container('instanceStatusSet')      is rw; 
  has Str               $.nextToken          is xml-element                                               is rw; 
}