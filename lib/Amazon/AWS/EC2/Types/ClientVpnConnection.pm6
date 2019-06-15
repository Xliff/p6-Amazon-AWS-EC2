use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;

use Amazon::AWS::EC2::Types::ClientVpnConnectionStatus;

class Amazon::AWS::EC2::Types::ClientVpnConnection is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Str                          $.clientIp                     is xml-element    is xml-skip-null          is rw; 
  has Str                          $.clientVpnEndpointId          is xml-element    is xml-skip-null          is rw; 
  has Str                          $.commonName                   is xml-element    is xml-skip-null          is rw; 
  has Str                          $.connectionEndTime            is xml-element    is xml-skip-null          is rw; 
  has Str                          $.connectionEstablishedTime    is xml-element    is xml-skip-null          is rw; 
  has Str                          $.connectionId                 is xml-element    is xml-skip-null          is rw; 
  has Str                          $.egressBytes                  is xml-element    is xml-skip-null          is rw; 
  has Str                          $.egressPackets                is xml-element    is xml-skip-null          is rw; 
  has Str                          $.ingressBytes                 is xml-element    is xml-skip-null          is rw; 
  has Str                          $.ingressPackets               is xml-element    is xml-skip-null          is rw; 
  has ClientVpnConnectionStatus    $.status                       is xml-element    is xml-skip-null          is rw; 
  has Str                          $.timestamp                    is xml-element    is xml-skip-null          is rw; 
  has Str                          $.username                     is xml-element    is xml-skip-null          is rw; 
}