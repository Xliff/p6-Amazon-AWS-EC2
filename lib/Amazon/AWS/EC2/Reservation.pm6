use v6.d;

use Amazon::AWS::EC2::Base;

use Amazon::AWS::EC2::GroupIdentifier;
use Amazon::AWS::EC2::Instance;

use XML::Class;

class Amazon::AWS::EC2::Reservation is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Base;

  has Str             $.ownerId           is xml-element                   is rw;
  has Str             $.requesterId       is xml-element                   is rw;
  has Str             $.reservationId     is xml-element                   is rw;

  has GroupIdentifier @.groups            is xml-container('groupSet')     is rw;
  has Instance        @.instances         is xml-container('instancesSet') is rw;
}
