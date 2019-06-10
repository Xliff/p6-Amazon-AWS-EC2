use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;



class Amazon::AWS::EC2::Types::InstanceCreditSpecification is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Str    $.cpuCredits    is xml-element          is rw; 
  has Str    $.instanceId    is xml-element          is rw; 
}