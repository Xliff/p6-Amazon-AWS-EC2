use v6.d;

use XML::Class;

role Amazon::AWS::EC2::Roles::InstanceState is export
  does XML::Class
{
  has Int $.code is xml-element is rw;
  has Str $.name is xml-element is rw;
}
