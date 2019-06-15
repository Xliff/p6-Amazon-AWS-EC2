use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;

use Amazon::AWS::EC2::Types::ClientVpnRouteStatus;

class Amazon::AWS::EC2::Types::ClientVpnRoute is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Str                     $.clientVpnEndpointId    is xml-element    is xml-skip-null          is rw; 
  has Str                     $.description            is xml-element    is xml-skip-null          is rw; 
  has Str                     $.destinationCidr        is xml-element    is xml-skip-null          is rw; 
  has Str                     $.origin                 is xml-element    is xml-skip-null          is rw; 
  has ClientVpnRouteStatus    $.status                 is xml-element    is xml-skip-null          is rw; 
  has Str                     $.targetSubnet           is xml-element    is xml-skip-null          is rw; 
  has Str                     $.type                   is xml-element    is xml-skip-null          is rw; 
}