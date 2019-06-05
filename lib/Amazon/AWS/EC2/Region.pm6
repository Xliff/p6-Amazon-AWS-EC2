use v6.c;

use XML::Class;

class Amazon::AWS::EC2::Region is export
  does XML::Class[xml-element => 'item']
{
  has $.regionName     is xml-element;
  has $.regionEndpoint is xml-element;
}
