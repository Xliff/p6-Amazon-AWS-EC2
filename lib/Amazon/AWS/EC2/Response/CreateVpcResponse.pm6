use v6.d;

use Amazon::AWS::Roles::Response;

use XML::Class;

use Amazon::AWS::EC2::Types::Vpc;

class Amazon::AWS::EC2::Response::CreateVpcResponse is export
  does XML::Class[xml-element => 'CreateVpcResponse']
{
  also does Amazon::AWS::Roles::Response;

  has Vpc $.vpc is xml-element('vpc', :over-ride) is xml-skip-null is rw; 
}
