use v6.d;

use Amazon::AWS::Roles::Response;

use XML::Class;

use Amazon::AWS::EC2::Types::CancelledSpotInstanceRequest;

class Amazon::AWS::EC2::Response::CancelSpotInstanceRequestsResponse is export
  does XML::Class[xml-element => 'item']
{
  also does Amazon::AWS::Roles::Response;

  has CancelledSpotInstanceRequest    @.spotInstanceRequests    is xml-element    is xml-container('spotInstanceRequestSet')      is rw; 
}