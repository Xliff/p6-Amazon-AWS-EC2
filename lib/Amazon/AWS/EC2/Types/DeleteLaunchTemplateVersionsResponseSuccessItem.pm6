use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;



class Amazon::AWS::EC2::Types::DeleteLaunchTemplateVersionsResponseSuccessItem is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Str    $.launchTemplateId      is xml-element    is xml-skip-null          is rw; 
  has Str    $.launchTemplateName    is xml-element    is xml-skip-null          is rw; 
  has Int    $.versionNumber         is xml-element    is xml-skip-null          is rw; 
}