use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;

use Amazon::AWS::EC2::Types::LaunchTemplateSpotMarketOptionsRequest;

class Amazon::AWS::EC2::Types::LaunchTemplateInstanceMarketOptionsRequest is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Str                                       $.MarketType     is xml-element          is rw;   #=  spot
  has LaunchTemplateSpotMarketOptionsRequest    $.SpotOptions    is xml-element          is rw; 
}