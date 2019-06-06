use v6.d;

use XML::Class;

class Amazon::AWS::EC2::CapacityReservationTarget is export
  does XML::Class[xml-element => 'CapacityReservationTarget']
{
  has Str $.CapacityReservationId is xml-element is rw;
}
