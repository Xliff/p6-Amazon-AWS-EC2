use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;

use Amazon::AWS::EC2::Types::GroupIdentifier;
use Amazon::AWS::EC2::Types::Instance;

class Amazon::AWS::EC2::Types::Reservation is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has GroupIdentifier    @.groups           is xml-element    is xml-skip-null    is xml-container('groupSet')          is rw; 
  has Instance           @.instancess       is xml-element    is xml-skip-null    is xml-container('instancesSet')      is rw; 
  has Str                $.ownerId          is xml-element    is xml-skip-null                                          is rw; 
  has Str                $.requesterId      is xml-element    is xml-skip-null                                          is rw; 
  has Str                $.reservationId    is xml-element    is xml-skip-null                                          is rw; 
}