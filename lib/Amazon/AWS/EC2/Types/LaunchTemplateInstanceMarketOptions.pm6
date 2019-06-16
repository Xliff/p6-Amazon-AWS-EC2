use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;

use Amazon::AWS::EC2::Types::LaunchTemplateSpotMarketOptions;

class Amazon::AWS::EC2::Types::LaunchTemplateInstanceMarketOptions is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Str                                $.marketType     is xml-element                is xml-skip-null          is rw;   #=  spot
  has LaunchTemplateSpotMarketOptions    $.spotOptions    is xml-element(:over-ride)    is xml-skip-null          is rw;
}
