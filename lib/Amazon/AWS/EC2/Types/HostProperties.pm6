use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;



class Amazon::AWS::EC2::Types::HostProperties is export
  does XML::Class
{
  also is Amazon::AWS::EC2::Types::Base;

  has Int    $.cores           is xml-element    is xml-skip-null          is rw;
  has Str    $.instanceType    is xml-element    is xml-skip-null          is rw;
  has Int    $.sockets         is xml-element    is xml-skip-null          is rw;
  has Int    $.totalVCpus      is xml-element    is xml-skip-null          is rw;
}
