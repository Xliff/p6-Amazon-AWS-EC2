use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;



class Amazon::AWS::EC2::Types::EventInformation is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Str    $.eventDescription    is xml-element    is xml-skip-null          is rw; 
  has Str    $.eventSubType        is xml-element    is xml-skip-null          is rw; 
  has Str    $.instanceId          is xml-element    is xml-skip-null          is rw; 
}