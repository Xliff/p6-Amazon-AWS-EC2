use v6.d;

use Amazon::AWS::Roles::Response;

use XML::Class;

use Amazon::AWS::EC2::Types::NetworkInterface;

class Amazon::AWS::EC2::Response::CreateNetworkInterfaceResponse is export
  does XML::Class[xml-element => 'CreateNetworkInterfaceResponse']
{
  also does Amazon::AWS::Roles::Response;
  
  has NetworkInterface    $.networkInterface is xml-element(:over-ride) is xml-skip-null is rw;
}
