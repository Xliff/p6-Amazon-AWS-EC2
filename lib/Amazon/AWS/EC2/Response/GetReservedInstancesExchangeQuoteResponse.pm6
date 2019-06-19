use v6.d;

use Amazon::AWS::Roles::Response;

use XML::Class;

use Amazon::AWS::EC2::Types::ReservationValue;
use Amazon::AWS::EC2::Types::ReservedInstanceReservationValue;
use Amazon::AWS::EC2::Types::TargetReservationValue;

class Amazon::AWS::EC2::Response::GetReservedInstancesExchangeQuoteResponse is export
  does XML::Class[xml-element => 'GetReservedInstancesExchangeQuoteResponse']
{
  also does Amazon::AWS::Roles::Response;

  has Str                                 $.currencyCode                           is xml-element                                                         is rw; 
  has Bool                                $.isValidExchange                        is xml-element                                                         is rw; 
  has Str                                 $.outputReservedInstancesWillExpireAt    is xml-element                                                         is rw; 
  has Str                                 $.paymentDue                             is xml-element                                                         is rw; 
  has ReservationValue                    $.reservedInstanceValueRollup            is xml-element                                                         is rw; 
  has ReservedInstanceReservationValue    @.reservedInstances                      is xml-element    is xml-container('reservedInstanceValueSet')         is rw; 
  has ReservationValue                    $.targetConfigurationValueRollup         is xml-element                                                         is rw; 
  has TargetReservationValue              @.targetConfigurations                   is xml-element    is xml-container('targetConfigurationValueSet')      is rw; 
  has Str                                 $.validationFailureReason                is xml-element                                                         is rw; 
}