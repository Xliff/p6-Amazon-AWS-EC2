use v6.c;

use XML::Class;

use Amazon::AWS::Roles::Base;

class Amazon::AWS::EC2::Filters::DescribeInstanceStatusFilter::Event
  does XML::Class[xml-element => 'event']
{
  has Str            $.code                is xml-element is rw;  #= instance-reboot | system-reboot | system-maintenance | instance-retirement | instance-stop
  has Str            $.description         is xml-element is rw;
  has Str            $.instance-event-id   is xml-element is rw;
  has Str            $.not-after           is xml-element is rw;
  has Str            $.not-before          is xml-element is rw;
  has Str            $.not-before-deadline is xml-element is rw;
}

class Amazon::AWS::EC2::Filters::DescribeInstanceStatusFilter::InstanceStatus
  does XML::Class[xml-element => 'instance-status']
{
  has Str            $.reachability        is xml-element is rw;  #= passed | failed | initializing | insufficient-data
  has Str            $.status              is xml-element is rw;  #= ok | impaired | initializing | insufficient-data | not-applicable
}

class Amazon::AWS::EC2::Filters::DescribeInstanceStatusFilter::SystemStatus
  does XML::Class[xml-element => 'system-status']
{
  has Str            $.reachability        is xml-element is rw;  #= passed | failed | initializing | insufficient-data
  has Str            $.status              is xml-element is rw;  #= ok | impaired | initializing | insufficient-data | not-applicable
}

constant Event              := Amazon::AWS::EC2::Filters::DescribeInstanceStatusFilter::Event;
constant ReachabilityStatus := Amazon::AWS::EC2::Filters::DescribeInstanceStatusFilter::InstanceStatus;
constant SystemStatus       := Amazon::AWS::EC2::Filters::DescribeInstanceStatusFilter::SystemStatus;

class Amazon::AWS::EC2::Filters::DescribeInstanceStatusFilter is export
  does XML::Class[xml-element => 'item']
{
  has Str            $.availability-zone   is xml-element is rw;
  has Event          $.event                              is rw;
  has Int            $.instance-state-code is xml-element is rw;
  has InstanceStatus $.instance-status                    is rw;
  has SystemStatus   $.system-status                      is rw;
}
