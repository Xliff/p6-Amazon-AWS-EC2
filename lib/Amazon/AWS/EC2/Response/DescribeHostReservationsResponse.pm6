use v6.d;

use Amazon::AWS::Roles::Response;

use XML::Class;

use Amazon::AWS::EC2::Types::HostReservation;

class Amazon::AWS::EC2::Response::DescribeHostReservationsResponse is export
  does XML::Class[xml-element => 'item']
{
  also does Amazon::AWS::Roles::Response;

  has HostReservation    @.hostReservations    is xml-element    is xml-container('hostReservationSet')      is rw; 
  has Str                $.nextToken           is xml-element                                                is rw; 
}