use v6.d;

use Amazon::AWS::Roles::Response;

use XML::Class;

use Amazon::AWS::EC2::Types::LaunchTemplate;

class Amazon::AWS::EC2::Response::DescribeLaunchTemplatesResponse is export
  does XML::Class[xml-element => 'item']
{
  also does Amazon::AWS::Roles::Response;

  has LaunchTemplate    @.launchTemplates    is xml-element    is xml-container('launchTemplates')      is rw; 
  has Str               $.nextToken          is xml-element                                             is rw; 
}