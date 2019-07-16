use v6.d;

use XML::Class;

use Amazon::AWS::Roles::Base;
use Amazon::AWS::Roles::Eqv;

use Amazon::AWS::Utils;

my %attributes;

class Amazon::AWS::EC2::Filters::DescribeVpcEndpointConnectionNotificationsFilter 
  is export
  does XML::Class[xml-element => 'item']
{
  also does Amazon::AWS::Roles::Base;
  also does Amazon::AWS::Roles::Eqv;

  has Str $.connection-notification-arn    is xml-element is rw;
  has Str $.connection-notification-id     is xml-element is rw; 
  has Str $.connection-notification-state  is xml-element is rw;  #=  Enabled | Disabled
  has Str $.connection-notification-type   is xml-element is rw;  
  has Str $.service-id                     is xml-element is rw;
  has Str $.vpc-endpoint-id                is xml-element is rw;
  
  method getValidStates {
    %attributes<connection-notification-state|ValidValues>.Array;
  }
}

BEGIN {
  %attributes = getAttributeData(
    Amazon::AWS::EC2::Filters::DescribeVpcEndpointConnectionNotificationsFilter
  );
}
