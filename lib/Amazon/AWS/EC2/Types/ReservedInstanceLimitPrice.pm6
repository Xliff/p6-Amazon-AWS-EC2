use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;



class Amazon::AWS::EC2::Types::ReservedInstanceLimitPrice is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Num    $.Amount          is xml-element    is xml-skip-null          is rw; 
  has Str    $.CurrencyCode    is xml-element    is xml-skip-null          is rw;   #=  USD
}