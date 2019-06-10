use v6.d;

use Amazon::AWS::Roles::Response;

use XML::Class;

use Amazon::AWS::EC2::Types::ScheduledInstanceAvailability;

class Amazon::AWS::EC2::Types::Response::DescribeScheduledInstanceAvailabilityResponse is export
  does XML::Class[xml-element => 'item']
{
  also does Amazon::AWS::Roles::Response;

  has Str                              $.nextToken                         is xml-element                                                              is rw; 
  has ScheduledInstanceAvailability    @.scheduledInstanceAvailabilitys    is xml-element    is xml-container('scheduledInstanceAvailabilitySet')      is rw; 
}