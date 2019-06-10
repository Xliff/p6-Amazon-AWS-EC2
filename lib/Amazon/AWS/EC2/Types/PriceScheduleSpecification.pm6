use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;

class Amazon::AWS::EC2::Types::PriceScheduleSpecification is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Str    $.CurrencyCode    is xml-element          is rw;   #=  USD
  has Num    $.Price           is xml-element          is rw;
  has Int    $.Term            is xml-element          is rw;
}