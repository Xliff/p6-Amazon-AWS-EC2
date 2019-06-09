use v6.d;

use XML::Class;

use Amazon::AWS::EC2::Types::Base;

class Amazon::AWS::EC2::Types::IpRange is export 
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;
  
  # Request
  has Str $.CdrIp       is xml-element is rw;  #= Max /32
  has Str $.Description is xml-element is rw;  #=  Up to 255 characters in length. Allowed characters are a-z, A-Z, 0-9, spaces, and ._-:/()#,@[]+=;{}!$*
  
  # Response
  has Str $.cdrIp       is xml-element is rw;  #= Max /32s
  has Str $.description is xml-element is rw;  #=  Up to 255 characters in length. Allowed characters are a-z, A-Z, 0-9, spaces, and ._-:/()#,@[]+=;{}!$*
}
