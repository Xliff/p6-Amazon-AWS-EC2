use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;

use Amazon::AWS::EC2::Types::CapacityReservationTarget;


# Needs Attribute tracking code
class Amazon::AWS::EC2::Types::CapacityReservationSpecification is export
  does XML::Class
{
  also is Amazon::AWS::EC2::Types::Base;

  has Str                       $.CapacityReservationPreference is xml-element is xml-skip-null is rw;  #= open | none
  has CapacityReservationTarget $.CapacityReservationTarget                    is xml-skip-null is rw;

}
