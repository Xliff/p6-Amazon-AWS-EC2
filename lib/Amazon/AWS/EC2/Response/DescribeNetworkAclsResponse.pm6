use v6.d;

use Amazon::AWS::Roles::Response;

use XML::Class;

use Amazon::AWS::EC2::Types::NetworkAcl;

class Amazon::AWS::EC2::Response::DescribeNetworkAclsResponse is export
  does XML::Class[xml-element => 'DescribeNetworkAclsResponse']
{
  also does Amazon::AWS::Roles::Response;

  has NetworkAcl    @.NetworkAcls                    is xml-container('networkAclset')  is rw; 
  has Str           $.nextToken    is xml-element                                       is rw; 
}
