use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;



class Amazon::AWS::EC2::Types::PeeringConnectionOptionsRequest is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Bool    $.AllowDnsResolutionFromRemoteVpc               is xml-element          is rw; 
  has Bool    $.AllowEgressFromLocalClassicLinkToRemoteVpc    is xml-element          is rw; 
  has Bool    $.AllowEgressFromLocalVpcToRemoteClassicLink    is xml-element          is rw; 
}