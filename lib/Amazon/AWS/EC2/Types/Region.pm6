use v6.c;

use XML::Class;

use Amazon::AWS::EC2::Types::Base;

class Amazon::AWS::EC2::Types::Region is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Str $.regionName     is xml-element is rw;
  has Str $.regionEndpoint is xml-element is rw;
}
