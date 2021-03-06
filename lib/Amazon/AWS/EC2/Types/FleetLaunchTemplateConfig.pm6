use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;

use Amazon::AWS::EC2::Types::FleetLaunchTemplateOverrides;
use Amazon::AWS::EC2::Types::FleetLaunchTemplateSpecification;

class Amazon::AWS::EC2::Types::FleetLaunchTemplateConfig is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has FleetLaunchTemplateSpecification    $.launchTemplateSpecification    is xml-element(        :over-ride)    is xml-skip-null                                     is rw; 
  has FleetLaunchTemplateOverrides        @.overrides                      is xml-element('item', :over-ride)    is xml-skip-null    is xml-container('overrides')    is rw; 
}
