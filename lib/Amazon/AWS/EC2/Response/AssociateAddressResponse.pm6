use v6.d;

use Amazon::AWS::Roles::Response;

use XML::Class;



class Amazon::AWS::EC2::Response::AssociateAddressResponse is export
  does XML::Class[xml-element => 'AssociateAddressResponse']
{
  also does Amazon::AWS::Roles::Response;

  has Str    $.associationId    is xml-element          is rw; 
}