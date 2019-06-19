use v6.d;

use Amazon::AWS::Roles::Response;

use XML::Class;

use Amazon::AWS::EC2::Types::LaunchTemplateVersion;

class Amazon::AWS::EC2::Response::CreateLaunchTemplateVersionResponse is export
  does XML::Class[xml-element => 'CreateLaunchTemplateVersionResponse']
{
  also does Amazon::AWS::Roles::Response;

  has LaunchTemplateVersion    $.launchTemplateVersion    is xml-element          is rw; 
}