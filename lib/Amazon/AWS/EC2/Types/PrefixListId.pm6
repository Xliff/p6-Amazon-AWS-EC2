use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;



class Amazon::AWS::EC2::Types::PrefixListId is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Str    $.Description     is xml-element    is xml-skip-null          is rw; 
  has Str    $.description     is xml-element    is xml-skip-null          is rw; 
  has Str    $.PrefixListId    is xml-element    is xml-skip-null          is rw; 
  has Str    $.prefixListId    is xml-element    is xml-skip-null          is rw; 
}