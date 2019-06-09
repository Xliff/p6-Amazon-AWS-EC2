use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;

use Amazon::AWS::EC2::Types::InstanceCapacity;

class Amazon::AWS::EC2::Types::AvailableCapacity is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has InstanceCapacity    @.availableInstanceCapacity    is xml-element    is xml-container('availableInstanceCapacity')      is rw; 
  has Int                 $.availableVCpus               is xml-element                                                       is rw; 
}