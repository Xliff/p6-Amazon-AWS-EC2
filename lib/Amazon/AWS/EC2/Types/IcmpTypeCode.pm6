use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;



class Amazon::AWS::EC2::Types::IcmpTypeCode is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Int    $.Code    is xml-element    is xml-skip-null          is rw; 
  has Int    $.code    is xml-element    is xml-skip-null          is rw; 
  has Int    $.Type    is xml-element    is xml-skip-null          is rw; 
  has Int    $.type    is xml-element    is xml-skip-null          is rw; 
}