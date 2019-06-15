use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;



class Amazon::AWS::EC2::Types::PriceSchedule is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Bool    $.active          is xml-element    is xml-skip-null          is rw; 
  has Str     $.currencyCode    is xml-element    is xml-skip-null          is rw;   #=  USD
  has Num     $.price           is xml-element    is xml-skip-null          is rw; 
  has Int     $.term            is xml-element    is xml-skip-null          is rw; 
}