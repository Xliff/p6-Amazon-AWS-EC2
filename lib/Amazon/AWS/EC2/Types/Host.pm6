use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;

use Amazon::AWS::EC2::Types::AvailableCapacity;
use Amazon::AWS::EC2::Types::HostInstance;
use Amazon::AWS::EC2::Types::HostProperties;
use Amazon::AWS::EC2::Types::Tag;

class Amazon::AWS::EC2::Types::Host is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Str                  $.allocationTime       is xml-element    is xml-skip-null                                       is rw; 
  has Str                  $.autoPlacement        is xml-element    is xml-skip-null                                       is rw;   #=  on | off
  has Str                  $.availabilityZone     is xml-element    is xml-skip-null                                       is rw; 
  has AvailableCapacity    $.availableCapacity    is xml-element    is xml-skip-null                                       is rw; 
  has Str                  $.clientToken          is xml-element    is xml-skip-null                                       is rw; 
  has Str                  $.hostId               is xml-element    is xml-skip-null                                       is rw; 
  has HostProperties       $.hostProperties       is xml-element    is xml-skip-null                                       is rw; 
  has Str                  $.hostRecovery         is xml-element    is xml-skip-null                                       is rw;   #=  on | off
  has Str                  $.hostReservationId    is xml-element    is xml-skip-null                                       is rw; 
  has HostInstance         @.instances            is xml-element    is xml-skip-null    is xml-container('instances')      is rw; 
  has Str                  $.releaseTime          is xml-element    is xml-skip-null                                       is rw; 
  has Str                  $.state                is xml-element    is xml-skip-null                                       is rw;   #=  available | under-assessment | permanent-failure | released | released-permanent-failure | pending
  has Tag                  @.tags                 is xml-element    is xml-skip-null    is xml-container('tagSet')         is rw; 
}