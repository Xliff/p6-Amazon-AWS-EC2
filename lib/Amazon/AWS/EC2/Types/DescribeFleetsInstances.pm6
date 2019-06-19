use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;

use Amazon::AWS::EC2::Types::LaunchTemplateAndOverridesResponse;

class Amazon::AWS::EC2::Types::DescribeFleetsInstances is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Str                                   @.instanceIds                   is xml-element('item')        is xml-skip-null    is xml-container('instanceIds')      is rw;
  has Str                                   $.instanceType                  is xml-element                is xml-skip-null                                         is rw;   #=  sub:Amazon::AWS::EC2::validInstanceTypes::checkInstanceType
  has LaunchTemplateAndOverridesResponse    $.launchTemplateAndOverrides    is xml-element(:over-ride)    is xml-skip-null                                         is rw;
  has Str                                   $.lifecycle                     is xml-element                is xml-skip-null                                         is rw;   #=  spot | on-demand
  has Str                                   $.platform                      is xml-element                is xml-skip-null                                         is rw;   #=  Windows
}
