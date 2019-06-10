use v6.d;

use Amazon::AWS::Roles::Response;

use XML::Class;

use Amazon::AWS::EC2::Types::ReservedInstances;

class Amazon::AWS::EC2::Response::DescribeReservedInstancesResponse is export
  does XML::Class[xml-element => 'item']
{
  also does Amazon::AWS::Roles::Response;

  has ReservedInstances    @.reservedInstancess    is xml-element    is xml-container('reservedInstancesSet')      is rw; 
}