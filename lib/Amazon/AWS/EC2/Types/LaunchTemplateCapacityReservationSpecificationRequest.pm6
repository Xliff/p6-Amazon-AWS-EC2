use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;

use Amazon::AWS::EC2::Types::CapacityReservationTarget;

class Amazon::AWS::EC2::Types::LaunchTemplateCapacityReservationSpecificationRequest is export
  does XML::Class
{
  also is Amazon::AWS::EC2::Types::Base;

  has Str                          $.CapacityReservationPreference    is xml-element                is xml-skip-null          is rw;   #=  open | none
  has CapacityReservationTarget    $.CapacityReservationTarget        is xml-element(:over-ride)    is xml-skip-null          is rw;
}
