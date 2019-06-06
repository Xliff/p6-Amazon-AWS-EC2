use v6.c;

use XML::Class;

use Amazon::AWS::EC2::InstanceState;

class InstancesStateChange does does XML::Class[xml-element => 'item'] {
  also is Amazon::AWS::EC2::Base;

  has Str           $.instanceID    is xml-element is rw;
  has InstanceState $.currentState  is xml-element is rw;
  has InstanceState $.previousState is xml-element is rw;
}