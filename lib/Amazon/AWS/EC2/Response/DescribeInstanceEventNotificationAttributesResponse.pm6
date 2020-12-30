use v6.d;

use Amazon::AWS::Roles::Response;

use XML::Class;

use Amazon::AWS::EC2::Types::InstanceTagNotificationAttribute;

class Amazon::AWS::EC2::Response::DescribeInstanceEventNotificationAttributesResponse is export
  does XML::Class[xml-element => 'DescribeInstanceEventNotificationAttributesResponse']
{
  also does Amazon::AWS::Roles::Response;

  has InstanceTagNotificationAttribute    $.instanceTagAttribute    is xml-element(:over-ride)   is xml-skip-null          is rw;
}
