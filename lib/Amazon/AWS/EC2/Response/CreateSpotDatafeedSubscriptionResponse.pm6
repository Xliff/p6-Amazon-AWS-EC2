use v6.d;

use Amazon::AWS::Roles::Response;

use XML::Class;

use Amazon::AWS::EC2::Types::SpotDatafeedSubscription;

class Amazon::AWS::EC2::Response::CreateSpotDatafeedSubscriptionResponse is export
  does XML::Class[xml-element => 'item']
{
  also does Amazon::AWS::Roles::Response;

  has SpotDatafeedSubscription    $.spotDatafeedSubscription    is xml-element          is rw; 
}