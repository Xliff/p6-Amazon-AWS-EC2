use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;

use Amazon::AWS::EC2::Types::DeleteFleetError;

class Amazon::AWS::EC2::Types::DeleteFleetErrorItem is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has DeleteFleetError    $.error      is xml-element          is rw; 
  has Str                 $.fleetId    is xml-element          is rw; 
}