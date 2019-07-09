use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;



class Amazon::AWS::EC2::Types::PrefixList is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Str    @.cidrs             is xml-element('item')    is xml-container('cidrSet')  is xml-skip-null is rw; 
  has Str    $.prefixListId      is xml-element                                         is xml-skip-null is rw; 
  has Str    $.prefixListName    is xml-element                                         is xml-skip-null is rw; 
}
