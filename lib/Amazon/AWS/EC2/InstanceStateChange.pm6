use v6.c;

use XML::Class;

use Amazon::AWS::EC2::InstanceState;

class InstancesStateChange does does XML::Class[xml-element => 'item'] {
  has Str           $.instanceID    is xml-element;
  has InstanceState $.currentState  is xml-element;
  has InstanceState $.previousState is xml-element;
}
