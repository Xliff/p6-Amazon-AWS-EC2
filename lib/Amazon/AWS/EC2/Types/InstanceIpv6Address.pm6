use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;



class Amazon::AWS::EC2::Types::InstanceIpv6Address is export
  does XML::Class
{
  also is Amazon::AWS::EC2::Types::Base;

  has Str    $.Ipv6Address    is xml-element    is xml-skip-null          is rw;
  has Str    $.ipv6Address    is xml-element    is xml-skip-null          is rw;
}
