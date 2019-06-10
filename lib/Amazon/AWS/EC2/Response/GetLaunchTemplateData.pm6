use v6.d;

use Amazon::AWS::Roles::Response;

use XML::Class;

use Amazon::AWS::EC2::Types::ResponseLaunchTemplateData;

class Amazon::AWS::EC2::Types::Response::GetLaunchTemplateDataResponse is export
  does XML::Class[xml-element => 'item']
{
  also does Amazon::AWS::Roles::Response;

  has ResponseLaunchTemplateData    $.launchTemplateData    is xml-element          is rw; 
}