use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;



class Amazon::AWS::EC2::Types::TargetConfigurationRequest is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Int    $.InstanceCount    is xml-element          is rw; 
  has Str    $.OfferingId       is xml-element          is rw; 
}