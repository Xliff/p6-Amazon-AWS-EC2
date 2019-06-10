use v6.d;

use Amazon::AWS::Roles::Response;

use XML::Class;

use Amazon::AWS::EC2::Types::SpotFleetRequestConfig;

class Amazon::AWS::EC2::Types::Response::DescribeSpotFleetRequestsResponse is export
  does XML::Class[xml-element => 'item']
{
  also does Amazon::AWS::Roles::Response;

  has Str                       $.nextToken                  is xml-element                                                       is rw; 
  has SpotFleetRequestConfig    @.spotFleetRequestConfigs    is xml-element    is xml-container('spotFleetRequestConfigSet')      is rw; 
}