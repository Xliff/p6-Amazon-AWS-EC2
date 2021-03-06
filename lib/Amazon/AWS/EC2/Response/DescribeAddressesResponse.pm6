use v6.d;

use Amazon::AWS::Roles::Response;

use XML::Class;

use Amazon::AWS::EC2::Types::Address;

class Amazon::AWS::EC2::Response::DescribeAddressesResponse is export
  does XML::Class[xml-element => 'DescribeAddressesResponse']
{
  also does Amazon::AWS::Roles::Response;

  has Address    @.addressess    is xml-container('addressesSet')    is rw; 
}
