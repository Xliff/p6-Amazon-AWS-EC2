use v6.d;

use XML::Class;

class Amazon::AWS::EC2::LicenseConfiguration is export
  does XML::Class[xml-element => 'item']
{
  has Str $.licenseConfigurationArn is xml-element is rw;
}
