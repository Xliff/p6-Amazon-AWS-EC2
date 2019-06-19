use v6.d;

use Amazon::AWS::Roles::Response;

use XML::Class;



class Amazon::AWS::EC2::Response::ModifyReservedInstancesResponse is export
  does XML::Class[xml-element => 'ModifyReservedInstancesResponse']
{
  also does Amazon::AWS::Roles::Response;

  has Str    $.reservedInstancesModificationId    is xml-element          is rw; 
}