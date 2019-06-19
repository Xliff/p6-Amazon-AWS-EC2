use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;



class Amazon::AWS::EC2::Types::TargetCapacitySpecificationRequest is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Str    $.DefaultTargetCapacityType    is xml-element    is xml-skip-null          is rw;   #=  spot | on-demand
  has Int    $.OnDemandTargetCapacity       is xml-element    is xml-skip-null          is rw; 
  has Int    $.SpotTargetCapacity           is xml-element    is xml-skip-null          is rw; 
  has Int    $.TotalTargetCapacity          is xml-element    is xml-skip-null          is rw; 
}