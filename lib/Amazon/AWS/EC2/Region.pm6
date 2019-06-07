use v6.c;

use XML::Class;

use Amazon::AWS::EC2::Base;

class Amazon::AWS::EC2::Region is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Base;

  has $.regionName     is xml-element is rw;
  has $.regionEndpoint is xml-element is rw;
}
