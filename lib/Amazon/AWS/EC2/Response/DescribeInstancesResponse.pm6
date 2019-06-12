use v6.d;

use XML::Class;

use Amazon::AWS::EC2::Types::Reservation;
use Amazon::AWS::Roles::Response;

class Amazon::AWS::EC2::Response::DescribeInstancesResponse is export
  does XML::Class[
    xml-element   => 'DescribeInstancesResponse',
    xml-namespace => 'http://ec2.amazonaws.com/doc/2016-11-15/'
  ]
{
  also does Amazon::AWS::Roles::Response;

  has Str         $.nextToken    is xml-element                     is rw;
  has Reservation @.reservations is xml-container('reservationSet') is rw;
}
