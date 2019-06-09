use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;

use Amazon::AWS::EC2::Types::ResponseLaunchTemplateData;

class Amazon::AWS::EC2::Types::LaunchTemplateVersion is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Str                           $.createdBy             is xml-element          is rw; 
  has Str                           $.createTime            is xml-element          is rw; 
  has Bool                          $.defaultVersion        is xml-element          is rw; 
  has ResponseLaunchTemplateData    $.launchTemplateData    is xml-element          is rw; 
  has Str                           $.launchTemplateId      is xml-element          is rw; 
  has Str                           $.launchTemplateName    is xml-element          is rw; 
  has Str                           $.versionDescription    is xml-element          is rw; 
  has Int                           $.versionNumber         is xml-element          is rw; 
}