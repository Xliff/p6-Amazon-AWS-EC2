use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;

use Amazon::AWS::EC2::Types::Tag;

class Amazon::AWS::EC2::Types::LaunchTemplate is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Str    $.createdBy               is xml-element    is xml-skip-null                                    is rw; 
  has Str    $.createTime              is xml-element    is xml-skip-null                                    is rw; 
  has Int    $.defaultVersionNumber    is xml-element    is xml-skip-null                                    is rw; 
  has Int    $.latestVersionNumber     is xml-element    is xml-skip-null                                    is rw; 
  has Str    $.launchTemplateId        is xml-element    is xml-skip-null                                    is rw; 
  has Str    $.launchTemplateName      is xml-element    is xml-skip-null                                    is rw; 
  has Tag    @.tags                    is xml-element    is xml-skip-null    is xml-container('tagSet')      is rw; 
}