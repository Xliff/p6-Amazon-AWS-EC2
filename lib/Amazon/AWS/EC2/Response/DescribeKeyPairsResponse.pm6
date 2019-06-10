use v6.d;

use Amazon::AWS::Roles::Response;

use XML::Class;

use Amazon::AWS::EC2::Types::KeyPairInfo;

class Amazon::AWS::EC2::Response::DescribeKeyPairsResponse is export
  does XML::Class[xml-element => 'item']
{
  also does Amazon::AWS::Roles::Response;

  has KeyPairInfo    @.keys    is xml-element    is xml-container('keySet')      is rw; 
}