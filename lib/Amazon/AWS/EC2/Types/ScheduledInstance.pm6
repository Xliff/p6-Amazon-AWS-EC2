use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;

use Amazon::AWS::EC2::Types::ScheduledInstanceRecurrence;

class Amazon::AWS::EC2::Types::ScheduledInstance is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Str                            $.availabilityZone               is xml-element          is rw; 
  has Str                            $.createDate                     is xml-element          is rw; 
  has Str                            $.hourlyPrice                    is xml-element          is rw; 
  has Int                            $.instanceCount                  is xml-element          is rw; 
  has Str                            $.instanceType                   is xml-element          is rw; 
  has Str                            $.networkPlatform                is xml-element          is rw; 
  has Str                            $.nextSlotStartTime              is xml-element          is rw; 
  has Str                            $.platform                       is xml-element          is rw; 
  has Str                            $.previousSlotEndTime            is xml-element          is rw; 
  has ScheduledInstanceRecurrence    $.recurrence                     is xml-element          is rw; 
  has Str                            $.scheduledInstanceId            is xml-element          is rw; 
  has Int                            $.slotDurationInHours            is xml-element          is rw; 
  has Str                            $.termEndDate                    is xml-element          is rw; 
  has Str                            $.termStartDate                  is xml-element          is rw; 
  has Int                            $.totalScheduledInstanceHours    is xml-element          is rw; 
}