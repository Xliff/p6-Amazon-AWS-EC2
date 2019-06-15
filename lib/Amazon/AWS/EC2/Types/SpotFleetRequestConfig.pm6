use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;

use Amazon::AWS::EC2::Types::SpotFleetRequestConfigData;

class Amazon::AWS::EC2::Types::SpotFleetRequestConfig is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Str                           $.activityStatus            is xml-element    is xml-skip-null          is rw;   #=  error | pending_fulfillment | pending_termination | fulfilled
  has Str                           $.createTime                is xml-element    is xml-skip-null          is rw; 
  has SpotFleetRequestConfigData    $.spotFleetRequestConfig    is xml-element    is xml-skip-null          is rw; 
  has Str                           $.spotFleetRequestId        is xml-element    is xml-skip-null          is rw; 
  has Str                           $.spotFleetRequestState     is xml-element    is xml-skip-null          is rw;   #=  submitted | active | cancelled | failed | cancelled_running | cancelled_terminating | modifying
}