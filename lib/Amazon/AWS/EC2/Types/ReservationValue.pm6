use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;



class Amazon::AWS::EC2::Types::ReservationValue is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Str    $.hourlyPrice              is xml-element    is xml-skip-null          is rw; 
  has Str    $.remainingTotalValue      is xml-element    is xml-skip-null          is rw; 
  has Str    $.remainingUpfrontValue    is xml-element    is xml-skip-null          is rw; 
}