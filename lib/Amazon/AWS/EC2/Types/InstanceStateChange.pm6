use v6.c;

use XML::Class;

use Amazon::AWS::EC2::Types::Base;

use Amazon::AWS::EC2::Roles::InstanceState;

class Amazon::AWS::EC2::Types::InstanceStateChange::currentState is export {
  also does Amazon::AWS::EC2::Roles::InstanceState;
}

class Amazon::AWS::EC2::Types::InstanceStateChange::previousState is export {
  also does Amazon::AWS::EC2::Roles::InstanceState;
}

class Amazon::AWS::EC2::Types::InstanceStateChange is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Str           $.instanceID    is xml-element is rw;
  has previousState $.previousState                is rw;
  has currentState  $.currentState                 is rw;
}
