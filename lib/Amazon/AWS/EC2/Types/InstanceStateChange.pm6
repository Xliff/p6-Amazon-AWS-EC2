use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;

use Amazon::AWS::EC2::Types::InstanceState;

class Amazon::AWS::EC2::Types::InstanceStateChange is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has InstanceState    $.currentState     is xml-element    is xml-skip-null          is rw; 
  has Str              $.instanceId       is xml-element    is xml-skip-null          is rw; 
  has InstanceState    $.previousState    is xml-element    is xml-skip-null          is rw; 
}