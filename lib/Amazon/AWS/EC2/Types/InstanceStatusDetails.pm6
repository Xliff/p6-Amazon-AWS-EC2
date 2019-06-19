use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;



class Amazon::AWS::EC2::Types::InstanceStatusDetails is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Str    $.impairedSince    is xml-element    is xml-skip-null          is rw; 
  has Str    $.name             is xml-element    is xml-skip-null          is rw;   #=  reachability
  has Str    $.status           is xml-element    is xml-skip-null          is rw;   #=  passed | failed | insufficient-data | initializing
}