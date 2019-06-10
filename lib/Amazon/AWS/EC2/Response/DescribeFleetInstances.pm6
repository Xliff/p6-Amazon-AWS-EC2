use v6.d;

use Amazon::AWS::Roles::Response;

use XML::Class;

use Amazon::AWS::EC2::Types::ActiveInstance;

class Amazon::AWS::EC2::Types::Response::DescribeFleetInstancesResponse is export
  does XML::Class[xml-element => 'item']
{
  also does Amazon::AWS::Roles::Response;

  has ActiveInstance    @.activeInstances    is xml-element    is xml-container('activeInstanceSet')      is rw; 
  has Str               $.fleetId            is xml-element                                               is rw; 
  has Str               $.nextToken          is xml-element                                               is rw; 
}