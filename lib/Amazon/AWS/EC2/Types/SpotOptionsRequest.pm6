use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;



class Amazon::AWS::EC2::Types::SpotOptionsRequest is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Str     $.AllocationStrategy              is xml-element    is xml-skip-null          is rw;   #=  lowest-price | diversified
  has Str     $.InstanceInterruptionBehavior    is xml-element    is xml-skip-null          is rw;   #=  hibernate | stop | terminate
  has Int     $.InstancePoolsToUseCount         is xml-element    is xml-skip-null          is rw; 
  has Int     $.MinTargetCapacity               is xml-element    is xml-skip-null          is rw; 
  has Bool    $.SingleAvailabilityZone          is xml-element    is xml-skip-null          is rw; 
  has Bool    $.SingleInstanceType              is xml-element    is xml-skip-null          is rw; 
}