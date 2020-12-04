use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;

class Amazon::AWS::EC2::Types::InferenceDeviceInfo is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Int    $.count           is xml-element    is xml-skip-null          is rw;
  has Str    $.manufacturer    is xml-element    is xml-skip-null          is rw;
  has Str    $.name            is xml-element    is xml-skip-null          is rw;
}
