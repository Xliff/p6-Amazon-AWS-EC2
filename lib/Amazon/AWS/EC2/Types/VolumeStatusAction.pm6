use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;



class Amazon::AWS::EC2::Types::VolumeStatusAction is export
  does XML::Class
{
  also is Amazon::AWS::EC2::Types::Base;

  has Str    $.code           is xml-element    is xml-skip-null          is rw;
  has Str    $.description    is xml-element    is xml-skip-null          is rw;
  has Str    $.eventId        is xml-element    is xml-skip-null          is rw;
  has Str    $.eventType      is xml-element    is xml-skip-null          is rw;
}
