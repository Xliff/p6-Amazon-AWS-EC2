use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;

use Amazon::AWS::EC2::Types::UnsuccessfulItemError;

class Amazon::AWS::EC2::Types::UnsuccessfulItem is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has UnsuccessfulItemError    $.error         is xml-element          is rw; 
  has Str                      $.resourceId    is xml-element          is rw; 
}