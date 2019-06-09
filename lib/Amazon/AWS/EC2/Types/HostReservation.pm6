use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;

use Amazon::AWS::EC2::Types::Tag;

class Amazon::AWS::EC2::Types::HostReservation is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Int    $.count                is xml-element                                       is rw; 
  has Str    $.currencyCode         is xml-element                                       is rw;   #=  USD
  has Int    $.duration             is xml-element                                       is rw; 
  has Str    $.end                  is xml-element                                       is rw; 
  has Str    @.hostIds              is xml-element    is xml-container('hostIdSet')      is rw; 
  has Str    $.hostReservationId    is xml-element                                       is rw; 
  has Str    $.hourlyPrice          is xml-element                                       is rw; 
  has Str    $.instanceFamily       is xml-element                                       is rw; 
  has Str    $.offeringId           is xml-element                                       is rw; 
  has Str    $.paymentOption        is xml-element                                       is rw;   #=  AllUpfront | PartialUpfront | NoUpfront
  has Str    $.start                is xml-element                                       is rw; 
  has Str    $.state                is xml-element                                       is rw;   #=  payment-pending | payment-failed | active | retired
  has Tag    @.tags                 is xml-element    is xml-container('tagSet')         is rw; 
  has Str    $.upfrontPrice         is xml-element                                       is rw; 
}