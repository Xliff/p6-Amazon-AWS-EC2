use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;



class Amazon::AWS::EC2::Types::Purchase is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Str    $.currencyCode         is xml-element    is xml-skip-null                                       is rw;   #=  USD
  has Int    $.duration             is xml-element    is xml-skip-null                                       is rw; 
  has Str    @.hostIds              is xml-element    is xml-skip-null    is xml-container('hostIdSet')      is rw; 
  has Str    $.hostReservationId    is xml-element    is xml-skip-null                                       is rw; 
  has Str    $.hourlyPrice          is xml-element    is xml-skip-null                                       is rw; 
  has Str    $.instanceFamily       is xml-element    is xml-skip-null                                       is rw; 
  has Str    $.paymentOption        is xml-element    is xml-skip-null                                       is rw;   #=  AllUpfront | PartialUpfront | NoUpfront
  has Str    $.upfrontPrice         is xml-element    is xml-skip-null                                       is rw; 
}