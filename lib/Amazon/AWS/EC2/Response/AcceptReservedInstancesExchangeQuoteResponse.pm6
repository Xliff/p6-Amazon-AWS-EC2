use v6.d;

use Amazon::AWS::Roles::Response;

use XML::Class;



class Amazon::AWS::EC2::Response::AcceptReservedInstancesExchangeQuoteResponse is export
  does XML::Class[xml-element => 'AcceptReservedInstancesExchangeQuoteResponse']
{
  also does Amazon::AWS::Roles::Response;

  has Str    $.exchangeId    is xml-element          is rw; 
}