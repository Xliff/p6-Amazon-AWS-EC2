use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;

use Amazon::AWS::EC2::Types::VolumeStatusAction;
use Amazon::AWS::EC2::Types::VolumeStatusEvent;
use Amazon::AWS::EC2::Types::VolumeStatusInfo;

class Amazon::AWS::EC2::Types::VolumeStatusItem is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has VolumeStatusAction    @.actionss            is xml-element    is xml-skip-null    is xml-container('actionsSet')      is rw; 
  has Str                   $.availabilityZone    is xml-element    is xml-skip-null                                        is rw; 
  has VolumeStatusEvent     @.eventss             is xml-element    is xml-skip-null    is xml-container('eventsSet')       is rw; 
  has Str                   $.volumeId            is xml-element    is xml-skip-null                                        is rw; 
  has VolumeStatusInfo      $.volumeStatus        is xml-element    is xml-skip-null                                        is rw; 
}