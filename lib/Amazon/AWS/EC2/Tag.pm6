use v6.d;

use XML::Class;

# Oh no... not again!

class Amazon::AWS::EC2::Tag is export
  does XML::Class[xml-element => 'item']
{
  # Request
  has Str $.Key   is xml-element;
  has Str $.Value is xml-element;

  # Response
  has Str $.key   is xml-element;
  has Str $.value is xml-element;
}
