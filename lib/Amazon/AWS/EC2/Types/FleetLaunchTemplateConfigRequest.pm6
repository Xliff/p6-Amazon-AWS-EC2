use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;

use Amazon::AWS::EC2::Types::FleetLaunchTemplateOverridesRequest;
use Amazon::AWS::EC2::Types::FleetLaunchTemplateSpecificationRequest;

class Amazon::AWS::EC2::Types::FleetLaunchTemplateConfigRequest is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has FleetLaunchTemplateSpecificationRequest    $.LaunchTemplateSpecification    is xml-element    is xml-skip-null                                       is rw; 
  has FleetLaunchTemplateOverridesRequest        @.Overrides                      is xml-element    is xml-skip-null    is xml-container('Overrides')      is rw; 
}