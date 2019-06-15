use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;

use Amazon::AWS::EC2::Types::ReservationValue;

class Amazon::AWS::EC2::Types::ReservedInstanceReservationValue is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has ReservationValue    $.reservationValue      is xml-element    is xml-skip-null          is rw; 
  has Str                 $.reservedInstanceId    is xml-element    is xml-skip-null          is rw; 
}