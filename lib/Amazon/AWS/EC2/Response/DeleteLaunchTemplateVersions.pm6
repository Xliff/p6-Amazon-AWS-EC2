use v6.d;

use Amazon::AWS::Roles::Response;

use XML::Class;

use Amazon::AWS::EC2::Types::DeleteLaunchTemplateVersionsResponseErrorItem;
use Amazon::AWS::EC2::Types::DeleteLaunchTemplateVersionsResponseSuccessItem;

class Amazon::AWS::EC2::Types::Response::DeleteLaunchTemplateVersionsResponse is export
  does XML::Class[xml-element => 'item']
{
  also does Amazon::AWS::Roles::Response;

  has DeleteLaunchTemplateVersionsResponseSuccessItem    @.successfullyDeletedLaunchTemplateVersions      is xml-element    is xml-container('successfullyDeletedLaunchTemplateVersionSet')        is rw; 
  has DeleteLaunchTemplateVersionsResponseErrorItem      @.unsuccessfullyDeletedLaunchTemplateVersions    is xml-element    is xml-container('unsuccessfullyDeletedLaunchTemplateVersionSet')      is rw; 
}