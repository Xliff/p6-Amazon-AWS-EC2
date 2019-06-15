use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;

use Amazon::AWS::EC2::Types::ClientVpnConnectionStatus;

class Amazon::AWS::EC2::Types::TerminateConnectionStatus is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Str                          $.connectionId      is xml-element                is xml-skip-null          is rw; 
  has ClientVpnConnectionStatus    $.currentStatus     is xml-element(:over-ride)    is xml-skip-null          is rw;
  has ClientVpnConnectionStatus    $.previousStatus    is xml-element(:over-ride)    is xml-skip-null          is rw;
}
