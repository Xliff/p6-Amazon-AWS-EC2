use v6.d;

use Amazon::AWS::Roles::Response;

use XML::Class;

use Amazon::AWS::EC2::Types::ReservedInstancesOffering;

class Amazon::AWS::EC2::Response::DescribeReservedInstancesOfferingsResponse is export
  does XML::Class[xml-element => 'item']
{
  also does Amazon::AWS::Roles::Response;

  has Str                          $.nextToken                      is xml-element                                                           is rw; 
  has ReservedInstancesOffering    @.reservedInstancesOfferingss    is xml-element    is xml-container('reservedInstancesOfferingsSet')      is rw; 
}