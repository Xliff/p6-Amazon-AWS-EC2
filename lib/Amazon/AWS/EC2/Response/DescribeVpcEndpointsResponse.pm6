use v6.d;

use Amazon::AWS::Roles::Response;

use XML::Class;

use Amazon::AWS::EC2::Types::VpcEndpoint;

class Amazon::AWS::EC2::Response::DescribeVpcEndpointsResponse is export
  does XML::Class[xml-element => 'DescribeVpcEndpointsResponse']
{
  also does Amazon::AWS::Roles::Response;

  has VpcEndpoint    @.VpcEndpoints  is xml-container('vpcEndpointSet')                   is xml-skip-null is rw; 
  has Str            $.nextToken                                           is xml-element is xml-skip-null is rw; 
}
