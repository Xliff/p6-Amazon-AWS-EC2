use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;

use Amazon::AWS::EC2::Types::ReservationValue;
use Amazon::AWS::EC2::Types::TargetConfiguration;

class Amazon::AWS::EC2::Types::TargetReservationValue is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has ReservationValue       $.reservationValue       is xml-element    is xml-skip-null          is rw; 
  has TargetConfiguration    $.targetConfiguration    is xml-element    is xml-skip-null          is rw; 
}