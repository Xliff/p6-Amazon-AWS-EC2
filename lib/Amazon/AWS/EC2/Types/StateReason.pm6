use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;

class Amazon::AWS::EC2::Types::StateReason is export
  does XML::Class[xml-element => 'stateReason']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Str $.code is xml-element is rw;
}