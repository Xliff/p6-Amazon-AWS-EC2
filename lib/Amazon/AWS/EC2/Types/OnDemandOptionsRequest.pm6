use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;



class Amazon::AWS::EC2::Types::OnDemandOptionsRequest is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Str     $.AllocationStrategy        is xml-element          is rw;   #=  lowest-price | prioritized
  has Int     $.MinTargetCapacity         is xml-element          is rw; 
  has Bool    $.SingleAvailabilityZone    is xml-element          is rw; 
  has Bool    $.SingleInstanceType        is xml-element          is rw; 
}