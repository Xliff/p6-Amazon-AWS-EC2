use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;

use Amazon::AWS::EC2::Types::VpnTunnelOptionsSpecification;

class Amazon::AWS::EC2::Types::VpnConnectionOptionsSpecification is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Bool                             $.StaticRoutesOnly    is xml-element                                           is rw; 
  has VpnTunnelOptionsSpecification    @.TunnelOptions       is xml-element    is xml-container('TunnelOptions')      is rw; 
}