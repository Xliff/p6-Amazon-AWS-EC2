use v6.d;

use Amazon::AWS::Roles::Response;

use XML::Class;

use Amazon::AWS::EC2::Types::SpotInstanceRequest;

class Amazon::AWS::EC2::Response::DescribeSpotInstanceRequestsResponse is export
  does XML::Class[xml-element => 'item']
{
  also does Amazon::AWS::Roles::Response;

  has Str                    $.nextToken               is xml-element                                                    is rw; 
  has SpotInstanceRequest    @.spotInstanceRequests    is xml-element    is xml-container('spotInstanceRequestSet')      is rw; 
}