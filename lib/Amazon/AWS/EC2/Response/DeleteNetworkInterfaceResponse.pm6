use v6.d;

use Amazon::AWS::Roles::Response;

use XML::Class;

class Amazon::AWS::EC2::Response::DeleteNetworkInterfaceResponse is export
  does XML::Class[xml-element => 'DeleteNetworkInterfaceResponse']
{
  also does Amazon::AWS::Roles::Response;

  has Bool    $.return    is xml-element          is rw; 
}
