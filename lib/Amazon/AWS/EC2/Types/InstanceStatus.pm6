use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;

use Amazon::AWS::EC2::Types::InstanceState;
use Amazon::AWS::EC2::Types::InstanceStatusEvent;
use Amazon::AWS::EC2::Types::InstanceStatusSummary;

class Amazon::AWS::EC2::Types::InstanceStatus is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Str                      $.availabilityZone    is xml-element                is xml-skip-null                                       is rw;
  has InstanceStatusEvent      @.events                                            is xml-skip-null    is xml-container('eventsSet')      is rw; 
  has Str                      $.instanceId          is xml-element                is xml-skip-null                                       is rw;
  has InstanceState            $.instanceState       is xml-element(:over-ride)    is xml-skip-null                                       is rw;
  has InstanceStatusSummary    $.instanceStatus      is xml-element(:over-ride)    is xml-skip-null                                       is rw;
  has InstanceStatusSummary    $.systemStatus        is xml-element(:over-ride)    is xml-skip-null                                       is rw;
}
