use v6.d;

use Amazon::AWS::Roles::Response;

use XML::Class;

use Amazon::AWS::EC2::Types::InstanceStatus;

class Amazon::AWS::EC2::Response::DescribeInstanceStatusResponse is export
  does XML::Class[
    xml-element => 'DescribeInstanceStatusResponse',
    xml-namespace => 'http://ec2.amazonaws.com/doc/2016-11-15/'
  ]
{
  also does Amazon::AWS::Roles::Response;

  has InstanceStatus    @.instanceStatus    is xml-container('instanceStatusSet')                     is rw;
  has Str               $.nextToken                                                  is xml-element   is rw;
}
