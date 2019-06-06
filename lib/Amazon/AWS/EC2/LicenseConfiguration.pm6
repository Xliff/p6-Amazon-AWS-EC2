use v6.d;

use Amazon::AWS::EC2::Base;

use XML::Class;

class Amazon::AWS::EC2::LicenseConfiguration is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Base;

  has Str $.licenseConfigurationArn is xml-element is rw;
}