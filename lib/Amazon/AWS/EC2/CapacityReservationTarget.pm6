use v6.d;

use Amazon::AWS::EC2::Base;

use XML::Class;

class Amazon::AWS::EC2::CapacityReservationTarget is export
  does XML::Class[xml-element => 'CapacityReservationTarget']
{
  also is Amazon::AWS::EC2::Base;

  has Str $.CapacityReservationId is xml-element is rw;
}