use v6.d;

use XML::Class;

use Amazon::AWS::EC2::Types::Base;

class Amazon::AWS::EC2::Types::PrefixListId is export 
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;
  
  # Request
  has Str $.Description  is xml-element is rw;  #= Up to 255 characters in length. Allowed characters are a-z, A-Z, 0-9, spaces, and ._-:/()#,@[]+=;{}!$*
  has Str $.PrefixListId is xml-element is rw;  #= 
  
  # Response
  has Str $.description  is xml-element is rw;  #= Up to 255 characters in length. Allowed characters are a-z, A-Z, 0-9, spaces, and ._-:/()#,@[]+=;{}!$*
  has Str $.prefixListId is xml-element is rw;  
}
