use v6.c;

use XML::Class;

use Amazon::AWS::EC2::Types::Base;

role Amazon::AWS::EC2::Types::InstanceStateChange::InstanceState does XML::Class {
  has Int $.code is xml-element is rw;
  has Str $.name is xml-element is rw;
}

class Amazon::AWS::EC2::Types::InstanceStateChange::currentState {
  also does Amazon::AWS::EC2::Types::InstanceStateChange::InstanceState;
}

class Amazon::AWS::EC2::Types::InstanceStateChange::previousState {
  also does Amazon::AWS::EC2::Types::InstanceStateChange::InstanceState;
}

class Amazon::AWS::EC2::Types::InstanceStateChange is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Str           $.instanceID    is xml-element                  is rw;
  has previousState $.previousState is xml-element('previousState') is rw;
  has currentState  $.currentState  is xml-element('currentState')  is rw;
}
