use v6.d;

use Amazon::AWS::Roles::Response;

use XML::Class;

use Amazon::AWS::EC2::Types::FleetData;

class Amazon::AWS::EC2::Response::DescribeFleetsResponse is export
  does XML::Class[xml-element => 'DescribeFleetsResponse']
{
  also does Amazon::AWS::Roles::Response;

  has FleetData    @.fleets       is xml-element    is xml-container('fleetSet')      is rw; 
  has Str          $.nextToken    is xml-element                                      is rw; 
}