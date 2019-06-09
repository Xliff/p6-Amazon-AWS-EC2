use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;



class Amazon::AWS::EC2::Types::InstanceStatusEvent is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Str    $.code                 is xml-element          is rw;   #=  instance-reboot | system-reboot | system-maintenance | instance-retirement | instance-stop
  has Str    $.description          is xml-element          is rw; 
  has Str    $.instanceEventId      is xml-element          is rw; 
  has Str    $.notAfter             is xml-element          is rw; 
  has Str    $.notBefore            is xml-element          is rw; 
  has Str    $.notBeforeDeadline    is xml-element          is rw; 
}