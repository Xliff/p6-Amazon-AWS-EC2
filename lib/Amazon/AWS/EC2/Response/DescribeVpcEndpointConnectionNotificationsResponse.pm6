use v6.d;

use Amazon::AWS::Roles::Response;

use XML::Class;

use Amazon::AWS::EC2::Types::ConnectionNotification;

class Amazon::AWS::EC2::Response::DescribeVpcEndpointConnectionNotificationsResponse is export
  does XML::Class[xml-element => 'DescribeVpcEndpointConnectionNotificationsResponse']
{
  also does Amazon::AWS::Roles::Response;

  has ConnectionNotification @.connectionNotifications
    is xml-container('connectionNotificationSet')  
    is xml-skip-null 
    is rw;
     
  has Str $.nextToken  is xml-element is xml-skip-null is rw; 
  
  # Member aliases.
  method notifications         { @.connectionNotifications }
}
