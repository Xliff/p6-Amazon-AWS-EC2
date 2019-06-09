use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;



class Amazon::AWS::EC2::Types::InstanceCreditSpecificationRequest is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Str    $.CpuCredits    is xml-element          is rw; 
  has Str    $.InstanceId    is xml-element          is rw; 
}