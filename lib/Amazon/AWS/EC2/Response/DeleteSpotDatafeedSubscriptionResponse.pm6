use v6.d;

use Amazon::AWS::Roles::Response;

use XML::Class;



class Amazon::AWS::EC2::Response::DeleteSpotDatafeedSubscriptionResponse is export
  does XML::Class[xml-element => 'DeleteSpotDatafeedSubscriptionResponse']
{
  also does Amazon::AWS::Roles::Response;

  has Bool    $.return    is xml-element          is rw; 
}