use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;



class Amazon::AWS::EC2::Types::AttributeBooleanValue is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Bool    $.Value    is xml-element          is rw; 
  has Bool    $.value    is xml-element          is rw; 
}