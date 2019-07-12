use v6.d;

use Amazon::AWS::Roles::Response;

use XML::Class;

use Amazon::AWS::EC2::Types::NetworkInterface;

class Amazon::AWS::EC2::Response::DescribeNetworkInterfacesResponse is export
  does XML::Class[xml-element => 'DescribeNetworkInterfacesResponse']
{
  also does Amazon::AWS::Roles::Response;

  has NetworkInterface    @.NetworkInterfaces    is xml-element('item', :over-ride) is xml-container('networkInterfaceSet')  is xml-skip-null is rw; 
  has Str                 $.nextToken            is xml-element                                                              is xml-skip-null is rw; 
}
