use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;



class Amazon::AWS::EC2::Types::TargetCapacitySpecification is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Str    $.defaultTargetCapacityType    is xml-element          is rw;   #=  spot | on-demand
  has Int    $.onDemandTargetCapacity       is xml-element          is rw; 
  has Int    $.spotTargetCapacity           is xml-element          is rw; 
  has Int    $.totalTargetCapacity          is xml-element          is rw; 
}