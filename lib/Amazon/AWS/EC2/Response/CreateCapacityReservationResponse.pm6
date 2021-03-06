use v6.d;

use Amazon::AWS::Roles::Response;

use XML::Class;

use Amazon::AWS::EC2::Types::CapacityReservation;

class Amazon::AWS::EC2::Response::CreateCapacityReservationResponse is export
  does XML::Class[xml-element => 'CreateCapacityReservationResponse']
{
  also does Amazon::AWS::Roles::Response;

  has CapacityReservation    $.capacityReservation    is xml-element          is rw; 
}