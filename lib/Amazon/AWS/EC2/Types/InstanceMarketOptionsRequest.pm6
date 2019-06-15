use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;

use Amazon::AWS::EC2::Types::SpotMarketOptions;

class Amazon::AWS::EC2::Types::InstanceMarketOptionsRequest is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Str                  $.MarketType     is xml-element    is xml-skip-null          is rw;   #=  spot
  has SpotMarketOptions    $.SpotOptions    is xml-element    is xml-skip-null          is rw; 
}