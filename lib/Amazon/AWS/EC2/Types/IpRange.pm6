use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;



class Amazon::AWS::EC2::Types::IpRange is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Str    $.CidrIp         is xml-element    is xml-skip-null          is rw; 
  has Str    $.cidrIp         is xml-element    is xml-skip-null          is rw; 
  has Str    $.Description    is xml-element    is xml-skip-null          is rw; 
  has Str    $.description    is xml-element    is xml-skip-null          is rw; 
}