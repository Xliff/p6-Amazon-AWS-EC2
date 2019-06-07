use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;

use Amazon::AWS::EC2::Types::CapacityReservationTarget;

class Amazon::AWS::EC2::Types::CapacityReservationSpecification is export
  does XML::Class[xml-element => 'capacityReservationSpecification']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Str                       $.CapacityReservationPreference is xml-element is rw;
  has CapacityReservationTarget $.CapacityReservationTarget                    is rw;

  method setReservationPreference ($val) {
    my @valid-values = <open none>;
    die "Invalid value '{$val}' given. Valid options are {
         @valid-values.join(', ') }"
    unless $val ~~ @valid-values.any;
    $!CapacityReservationPreference = $val;
  }

}
