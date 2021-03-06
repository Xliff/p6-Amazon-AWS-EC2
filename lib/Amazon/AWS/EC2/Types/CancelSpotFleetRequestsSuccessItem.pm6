use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;



class Amazon::AWS::EC2::Types::CancelSpotFleetRequestsSuccessItem is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Str    $.currentSpotFleetRequestState     is xml-element    is xml-skip-null          is rw;   #=  submitted | active | cancelled | failed | cancelled_running | cancelled_terminating | modifying
  has Str    $.previousSpotFleetRequestState    is xml-element    is xml-skip-null          is rw;   #=  submitted | active | cancelled | failed | cancelled_running | cancelled_terminating | modifying
  has Str    $.spotFleetRequestId               is xml-element    is xml-skip-null          is rw; 
}