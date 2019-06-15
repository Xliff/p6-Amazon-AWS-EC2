use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;



class Amazon::AWS::EC2::Types::ResponseError is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Str    $.code       is xml-element    is xml-skip-null          is rw;   #=  launchTemplateIdDoesNotExist | launchTemplateIdMalformed | launchTemplateNameDoesNotExist | launchTemplateNameMalformed | launchTemplateVersionDoesNotExist | unexpectedError
  has Str    $.message    is xml-element    is xml-skip-null          is rw; 
}