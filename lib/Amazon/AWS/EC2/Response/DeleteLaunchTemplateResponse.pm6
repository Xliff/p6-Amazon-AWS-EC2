use v6.d;

use Amazon::AWS::Roles::Response;

use XML::Class;

use Amazon::AWS::EC2::Types::LaunchTemplate;

class Amazon::AWS::EC2::Response::DeleteLaunchTemplateResponse is export
  does XML::Class[xml-element => 'DeleteLaunchTemplateResponse']
{
  also does Amazon::AWS::Roles::Response;

  has LaunchTemplate    $.launchTemplate    is xml-element          is rw; 
}