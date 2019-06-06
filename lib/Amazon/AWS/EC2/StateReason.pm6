use v6.d;

use XML::Class;

class Amazon::AWS::EC2::StateReason is export
  does XML::Class[xml-element => 'stateReason']
{
  has Str $.code is xml-element is rw;
}
