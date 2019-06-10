use v6.d;

use Amazon::AWS::Roles::Response;

use XML::Class;

use Amazon::AWS::EC2::Types::DeleteFleetErrorItem;
use Amazon::AWS::EC2::Types::DeleteFleetSuccessItem;

class Amazon::AWS::EC2::Types::Response::DeleteFleetsResponse is export
  does XML::Class[xml-element => 'item']
{
  also does Amazon::AWS::Roles::Response;

  has DeleteFleetSuccessItem    @.successfulFleetDeletions      is xml-element    is xml-container('successfulFleetDeletionSet')        is rw; 
  has DeleteFleetErrorItem      @.unsuccessfulFleetDeletions    is xml-element    is xml-container('unsuccessfulFleetDeletionSet')      is rw; 
}