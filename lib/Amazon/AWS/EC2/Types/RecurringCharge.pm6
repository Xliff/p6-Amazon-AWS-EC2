use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;



class Amazon::AWS::EC2::Types::RecurringCharge is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Num    $.amount       is xml-element    is xml-skip-null          is rw; 
  has Str    $.frequency    is xml-element    is xml-skip-null          is rw;   #=  Hourly
}