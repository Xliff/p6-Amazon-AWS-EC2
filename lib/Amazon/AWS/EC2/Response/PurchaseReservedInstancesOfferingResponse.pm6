use v6.d;

use Amazon::AWS::Roles::Response;

use XML::Class;



class Amazon::AWS::EC2::Response::PurchaseReservedInstancesOfferingResponse is export
  does XML::Class[xml-element => 'PurchaseReservedInstancesOfferingResponse']
{
  also does Amazon::AWS::Roles::Response;

  has Str    $.reservedInstancesId    is xml-element          is rw; 
}