use v6.d;

use Amazon::AWS::Roles::Response;

use XML::Class;

use Amazon::AWS::EC2::Types::CreateFleetError;
use Amazon::AWS::EC2::Types::CreateFleetInstance;

class Amazon::AWS::EC2::Response::CreateFleetResponse is export
  does XML::Class[xml-element => 'CreateFleetResponse']
{
  also does Amazon::AWS::Roles::Response;

  has CreateFleetError       @.errors            is xml-element    is xml-container('errorSet')              is rw; 
  has Str                    $.fleetId           is xml-element                                              is rw; 
  has CreateFleetInstance    @.fleetInstances    is xml-element    is xml-container('fleetInstanceSet')      is rw; 
}