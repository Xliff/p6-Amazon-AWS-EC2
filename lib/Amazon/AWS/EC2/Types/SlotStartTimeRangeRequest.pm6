use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;



class Amazon::AWS::EC2::Types::SlotStartTimeRangeRequest is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Str    $.EarliestTime    is xml-element          is rw; 
  has Str    $.LatestTime      is xml-element          is rw; 
}