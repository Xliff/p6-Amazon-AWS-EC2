use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;



class Amazon::AWS::EC2::Types::ScheduledInstanceRecurrenceRequest is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Str     $.Frequency                  is xml-element    is xml-skip-null                                            is rw; 
  has Int     $.Interval                   is xml-element    is xml-skip-null                                            is rw; 
  has Int     @.OccurrenceDays             is xml-element    is xml-skip-null    is xml-container('OccurrenceDays')      is rw; 
  has Bool    $.OccurrenceRelativeToEnd    is xml-element    is xml-skip-null                                            is rw; 
  has Str     $.OccurrenceUnit             is xml-element    is xml-skip-null                                            is rw; 
}