use v6.d;

use Amazon::AWS::Roles::Response;

use XML::Class;

use Amazon::AWS::EC2::Types::SpotDatafeedSubscription;

class Amazon::AWS::EC2::Response::DescribeSpotDatafeedSubscriptionResponse is export
  does XML::Class[xml-element => 'DescribeSpotDatafeedSubscriptionResponse']
{
  also does Amazon::AWS::Roles::Response;

  has SpotDatafeedSubscription    $.spotDatafeedSubscription    is xml-element          is rw; 
}