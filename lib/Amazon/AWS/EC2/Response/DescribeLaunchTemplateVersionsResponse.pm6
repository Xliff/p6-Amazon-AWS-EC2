use v6.d;

use Amazon::AWS::Roles::Response;

use XML::Class;

use Amazon::AWS::EC2::Types::LaunchTemplateVersion;

class Amazon::AWS::EC2::Response::DescribeLaunchTemplateVersionsResponse is export
  does XML::Class[xml-element => 'DescribeLaunchTemplateVersionsResponse']
{
  also does Amazon::AWS::Roles::Response;

  has LaunchTemplateVersion @.launchTemplateVersions
    is xml-container('launchTemplateVersionSet')
    is xml-skip-null
    is rw; 
    
  has Str $.nextToken               
    is xml-element
    is xml-skip-null
    is rw; 
}
