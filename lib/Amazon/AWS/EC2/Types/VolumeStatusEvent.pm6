use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;



class Amazon::AWS::EC2::Types::VolumeStatusEvent is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Str    $.description    is xml-element          is rw; 
  has Str    $.eventId        is xml-element          is rw; 
  has Str    $.eventType      is xml-element          is rw; 
  has Str    $.notAfter       is xml-element          is rw; 
  has Str    $.notBefore      is xml-element          is rw; 
}