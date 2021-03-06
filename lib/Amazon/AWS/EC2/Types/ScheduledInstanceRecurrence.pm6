use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;



class Amazon::AWS::EC2::Types::ScheduledInstanceRecurrence is export
  does XML::Class
{
  also is Amazon::AWS::EC2::Types::Base;

  has Str     $.frequency                  is xml-element            is xml-skip-null                                              is rw;  #= Daily | Weekly | Monthly
  has Int     $.interval                   is xml-element            is xml-skip-null                                              is rw;
  has Int     @.occurrenceDays             is xml-element('item')    is xml-skip-null    is xml-container('occurrenceDaySet')      is rw;
  has Bool    $.occurrenceRelativeToEnd    is xml-element            is xml-skip-null                                              is rw;
  has Str     $.occurrenceUnit             is xml-element            is xml-skip-null                                              is rw;  #= DayOfWeek | DayOfMonth
}
