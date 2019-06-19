use v6.d;

use Amazon::AWS::Roles::Response;

use XML::Class;

use Amazon::AWS::EC2::Types::Purchase;

class Amazon::AWS::EC2::Response::GetHostReservationPurchasePreviewResponse is export
  does XML::Class[xml-element => 'GetHostReservationPurchasePreviewResponse']
{
  also does Amazon::AWS::Roles::Response;

  has Str         $.currencyCode         is xml-element                                      is rw;   #=  USD
  has Purchase    @.purchase             is xml-element    is xml-container('purchase')      is rw; 
  has Str         $.totalHourlyPrice     is xml-element                                      is rw; 
  has Str         $.totalUpfrontPrice    is xml-element                                      is rw; 
}