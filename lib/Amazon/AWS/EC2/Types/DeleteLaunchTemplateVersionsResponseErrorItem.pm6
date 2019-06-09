use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;

use Amazon::AWS::EC2::Types::ResponseError;

class Amazon::AWS::EC2::Types::DeleteLaunchTemplateVersionsResponseErrorItem is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Str              $.launchTemplateId      is xml-element          is rw; 
  has Str              $.launchTemplateName    is xml-element          is rw; 
  has ResponseError    $.responseError         is xml-element          is rw; 
  has Int              $.versionNumber         is xml-element          is rw; 
}