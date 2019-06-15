use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;

use Amazon::AWS::EC2::Types::EventInformation;

class Amazon::AWS::EC2::Types::HistoryRecord is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has EventInformation    $.eventInformation    is xml-element    is xml-skip-null          is rw; 
  has Str                 $.eventType           is xml-element    is xml-skip-null          is rw;   #=  instanceChange | fleetRequestChange | error | information
  has Str                 $.timestamp           is xml-element    is xml-skip-null          is rw; 
}