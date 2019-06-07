use v6.c;

use XML::Class;

use Amazon::AWS::EC2::Base;

role Amazon::AWS::EC2::InstanceStateChange::InstanceState does XML::Class {
  has Int $.code is xml-element is rw;
  has Str $.name is xml-element is rw;
}

class Amazon::AWS::EC2::InstanceStateChange::currentState {
  also does Amazon::AWS::EC2::InstanceStateChange::InstanceState;
}

class Amazon::AWS::EC2::InstanceStateChange::previousState {
  also does Amazon::AWS::EC2::InstanceStateChange::InstanceState;
}

class Amazon::AWS::EC2::InstanceStateChange is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Base;

  has Str           $.instanceID    is xml-element                  is rw;
  has previousState $.previousState is xml-element('previousState') is rw;
  has currentState  $.currentState  is xml-element('currentState')  is rw;
}
