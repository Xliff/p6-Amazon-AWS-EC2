use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;

use Amazon::AWS::EC2::Types::AssociatedTargetNetwork;
use Amazon::AWS::EC2::Types::ClientVpnAuthentication;
use Amazon::AWS::EC2::Types::ClientVpnEndpointStatus;
use Amazon::AWS::EC2::Types::ConnectionLogResponseOptions;
use Amazon::AWS::EC2::Types::Tag;

class Amazon::AWS::EC2::Types::ClientVpnEndpoint is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has AssociatedTargetNetwork         @.associatedTargetNetwork                                  is xml-skip-null    is xml-container('associatedTargetNetwork')      is rw;
  has ClientVpnAuthentication         @.authenticationOptions                                    is xml-skip-null    is xml-container('authenticationOptions')        is rw;
  has Str                             $.clientCidrBlock            is xml-element                is xml-skip-null                                                     is rw;
  has Str                             $.clientVpnEndpointId        is xml-element                is xml-skip-null                                                     is rw;
  has ConnectionLogResponseOptions    $.connectionLogOptions       is xml-element(:over-ride)    is xml-skip-null                                                     is rw;
  has Str                             $.creationTime               is xml-element                is xml-skip-null                                                     is rw;
  has Str                             $.deletionTime               is xml-element                is xml-skip-null                                                     is rw;
  has Str                             $.description                is xml-element                is xml-skip-null                                                     is rw;
  has Str                             $.dnsName                    is xml-element                is xml-skip-null                                                     is rw;
  has Str                             @.dnsServer                                                is xml-skip-null    is xml-container('dnsServer')                    is rw;
  has Str                             $.serverCertificateArn       is xml-element                is xml-skip-null                                                     is rw;
  has Bool                            $.splitTunnel                is xml-element                is xml-skip-null                                                     is rw;
  has ClientVpnEndpointStatus         $.status                     is xml-element(:over-ride)    is xml-skip-null                                                     is rw;
  has Tag                             @.tags                                                     is xml-skip-null    is xml-container('tagSet')                       is rw;
  has Str                             $.transportProtocol          is xml-element                is xml-skip-null                                                     is rw;   #=  tcp | udp
  has Str                             $.vpnProtocol                is xml-element                is xml-skip-null                                                     is rw;   #=  openvpn
}
