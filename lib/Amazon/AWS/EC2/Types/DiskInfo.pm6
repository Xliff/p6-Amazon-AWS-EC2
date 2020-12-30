use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;

class Amazon::AWS::EC2::Types::DiskInfo is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Int    $.count       is xml-element    is xml-skip-null          is rw;
  has Int    $.sizeInGB    is xml-element    is xml-skip-null          is rw;
  has Str    $.type        is xml-element    is xml-skip-null          is rw;   #=  hdd | ssd
}
