use v6.d;

use Amazon::AWS::Roles::Response;

use XML::Class;

use Amazon::AWS::EC2::Types::NetworkInterface;

class Amazon::AWS::EC2::Response::DescribeNetworkInterfacesResponse is export
  does XML::Class[xml-element => 'DescribeNetworkInterfacesResponse']
{
  also does Amazon::AWS::Roles::Response;

  has NetworkInterface    @.NetworkInterfaces                    is xml-container('networkInterfaceSet')      is rw; 
  has Str                 $.nextToken            is xml-element                                                 is rw; 
}
