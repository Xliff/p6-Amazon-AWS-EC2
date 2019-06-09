use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;



class Amazon::AWS::EC2::Types::SpotMarketOptions is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Int    $.BlockDurationMinutes            is xml-element          is rw; 
  has Str    $.InstanceInterruptionBehavior    is xml-element          is rw;   #=  hibernate | stop | terminate
  has Str    $.MaxPrice                        is xml-element          is rw; 
  has Str    $.SpotInstanceType                is xml-element          is rw;   #=  one-time | persistent
  has Str    $.ValidUntil                      is xml-element          is rw; 
}