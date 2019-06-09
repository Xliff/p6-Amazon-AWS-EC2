use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;

use Amazon::AWS::EC2::Types::AvailabilityZoneMessage;

class Amazon::AWS::EC2::Types::AvailabilityZone is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has AvailabilityZoneMessage    @.messages      is xml-element    is xml-container('messageSet')      is rw; 
  has Str                        $.regionName    is xml-element                                        is rw; 
  has Str                        $.zoneId        is xml-element                                        is rw; 
  has Str                        $.zoneName      is xml-element                                        is rw; 
  has Str                        $.zoneState     is xml-element                                        is rw;   #=  available | information | impaired | unavailable
}