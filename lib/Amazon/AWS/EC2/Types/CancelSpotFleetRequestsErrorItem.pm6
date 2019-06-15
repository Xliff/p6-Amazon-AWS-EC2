use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;

use Amazon::AWS::EC2::Types::CancelSpotFleetRequestsError;

class Amazon::AWS::EC2::Types::CancelSpotFleetRequestsErrorItem is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has CancelSpotFleetRequestsError    $.error                 is xml-element    is xml-skip-null          is rw; 
  has Str                             $.spotFleetRequestId    is xml-element    is xml-skip-null          is rw; 
}