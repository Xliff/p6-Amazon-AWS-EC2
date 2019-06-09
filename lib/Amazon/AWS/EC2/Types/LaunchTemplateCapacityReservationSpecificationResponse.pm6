use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;

use Amazon::AWS::EC2::Types::CapacityReservationTargetResponse;

class Amazon::AWS::EC2::Types::LaunchTemplateCapacityReservationSpecificationResponse is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Str                                  $.capacityReservationPreference    is xml-element          is rw;   #=  open | none
  has CapacityReservationTargetResponse    $.capacityReservationTarget        is xml-element          is rw; 
}