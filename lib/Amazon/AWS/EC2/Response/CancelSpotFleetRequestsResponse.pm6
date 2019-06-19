use v6.d;

use Amazon::AWS::Roles::Response;

use XML::Class;

use Amazon::AWS::EC2::Types::CancelSpotFleetRequestsErrorItem;
use Amazon::AWS::EC2::Types::CancelSpotFleetRequestsSuccessItem;

class Amazon::AWS::EC2::Response::CancelSpotFleetRequestsResponse is export
  does XML::Class[xml-element => 'CancelSpotFleetRequestsResponse']
{
  also does Amazon::AWS::Roles::Response;

  has CancelSpotFleetRequestsSuccessItem    @.successfulFleetRequests      is xml-element    is xml-container('successfulFleetRequestSet')        is rw; 
  has CancelSpotFleetRequestsErrorItem      @.unsuccessfulFleetRequests    is xml-element    is xml-container('unsuccessfulFleetRequestSet')      is rw; 
}