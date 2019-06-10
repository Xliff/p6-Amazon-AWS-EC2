use v6.d;

use Amazon::AWS::Roles::Response;

use XML::Class;

use Amazon::AWS::EC2::Types::Address;

class Amazon::AWS::EC2::Types::Response::DescribeAddressesResponse is export
  does XML::Class[xml-element => 'item']
{
  also does Amazon::AWS::Roles::Response;

  has Address    @.addressess    is xml-element    is xml-container('addressesSet')      is rw; 
}