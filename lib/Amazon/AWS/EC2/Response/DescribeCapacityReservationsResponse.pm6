use v6.d;

use Amazon::AWS::Roles::Response;

use XML::Class;

use Amazon::AWS::EC2::Types::CapacityReservation;

class Amazon::AWS::EC2::Response::DescribeCapacityReservationsResponse is export
  does XML::Class[xml-element => 'DescribeCapacityReservationsResponse']
{
  also does Amazon::AWS::Roles::Response;

  has CapacityReservation    @.capacityReservations    is xml-element    is xml-container('capacityReservationSet')      is rw; 
  has Str                    $.nextToken               is xml-element                                                    is rw; 
}