use v6.d;

use Amazon::AWS::Roles::Response;

use XML::Class;

use Amazon::AWS::EC2::Types::ActiveInstance;

class Amazon::AWS::EC2::Response::DescribeSpotFleetInstancesResponse is export
  does XML::Class[xml-element => 'DescribeSpotFleetInstancesResponse']
{
  also does Amazon::AWS::Roles::Response;

  has ActiveInstance    @.activeInstances       is xml-element    is xml-container('activeInstanceSet')      is rw; 
  has Str               $.nextToken             is xml-element                                               is rw; 
  has Str               $.spotFleetRequestId    is xml-element                                               is rw; 
}