use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;

# Oh no... not again!

class Amazon::AWS::EC2::Types::Tag is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  # Request
  has Str $.Key   is xml-element is rw;
  has Str $.Value is xml-element is rw;

  # Response
  has Str $.key   is xml-element is rw;
  has Str $.value is xml-element is rw;
}