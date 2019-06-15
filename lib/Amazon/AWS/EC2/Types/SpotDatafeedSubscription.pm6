use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;

use Amazon::AWS::EC2::Types::SpotInstanceStateFault;

class Amazon::AWS::EC2::Types::SpotDatafeedSubscription is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Str                       $.bucket     is xml-element    is xml-skip-null          is rw; 
  has SpotInstanceStateFault    $.fault      is xml-element    is xml-skip-null          is rw; 
  has Str                       $.ownerId    is xml-element    is xml-skip-null          is rw; 
  has Str                       $.prefix     is xml-element    is xml-skip-null          is rw; 
  has Str                       $.state      is xml-element    is xml-skip-null          is rw;   #=  Active | Inactive
}