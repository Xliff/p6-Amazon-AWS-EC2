use v6.d;

use Amazon::AWS::Roles::Response;

use XML::Class;

use Amazon::AWS::EC2::Types::NetworkAcl;

class Amazon::AWS::EC2::Response::CreateNetworkAclResponse is export
  does XML::Class[xml-element => 'CreateNetworkAclResponse']
{
  also does Amazon::AWS::Roles::Response;

  has NetworkAcl  $.networkAcl  is xml-element(:over-ride) is xml-skip-null is rw; 
}
