use v6.d;

use Amazon::AWS::Roles::Response;

use XML::Class;

use Amazon::AWS::EC2::Types::ReservedInstancesModification;

class Amazon::AWS::EC2::Types::Response::DescribeReservedInstancesModificationsResponse is export
  does XML::Class[xml-element => 'item']
{
  also does Amazon::AWS::Roles::Response;

  has Str                              $.nextToken                          is xml-element                                                               is rw; 
  has ReservedInstancesModification    @.reservedInstancesModificationss    is xml-element    is xml-container('reservedInstancesModificationsSet')      is rw; 
}