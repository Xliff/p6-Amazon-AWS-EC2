use v6.d;

use Amazon::AWS::Roles::Response;

use XML::Class;

use Amazon::AWS::EC2::Types::VpcEndpointConnection;

class Amazon::AWS::EC2::Response::DescribeVpcEndpointConnectionsResponse is export
  does XML::Class[xml-element => 'DescribeVpcEndpointConnectionsResponse']
{
  also does Amazon::AWS::Roles::Response;

  has VpcEndpointConnection  @.VpcEndpointConnections  is xml-container('vpcEndpointConnectionSet')                 is xml-skip-null is rw; 
  has Str                    $.nextToken                                                             is xml-element is xml-skip-null is rw; 
}
