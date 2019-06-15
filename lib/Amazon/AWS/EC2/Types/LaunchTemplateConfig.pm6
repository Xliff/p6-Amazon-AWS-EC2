use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;

use Amazon::AWS::EC2::Types::FleetLaunchTemplateSpecification;
use Amazon::AWS::EC2::Types::LaunchTemplateOverrides;

class Amazon::AWS::EC2::Types::LaunchTemplateConfig is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has FleetLaunchTemplateSpecification    $.LaunchTemplateSpecification    is xml-element    is xml-skip-null                                       is rw; 
  has FleetLaunchTemplateSpecification    $.launchTemplateSpecification    is xml-element    is xml-skip-null                                       is rw; 
  has LaunchTemplateOverrides             @.Overrides                      is xml-element    is xml-skip-null    is xml-container('Overrides')      is rw; 
  has LaunchTemplateOverrides             @.overrides                      is xml-element    is xml-skip-null    is xml-container('overrides')      is rw; 
}