use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;

use Amazon::AWS::EC2::Types::Tag;
use Amazon::AWS::EC2::Types::VgwTelemetry;
use Amazon::AWS::EC2::Types::VpnConnectionOptions;
use Amazon::AWS::EC2::Types::VpnStaticRoute;

class Amazon::AWS::EC2::Types::VpnConnection is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Str                     $.category                        is xml-element                                          is rw; 
  has Str                     $.customerGatewayConfiguration    is xml-element                                          is rw; 
  has Str                     $.customerGatewayId               is xml-element                                          is rw; 
  has VpnConnectionOptions    $.options                         is xml-element                                          is rw; 
  has VpnStaticRoute          @.routes                          is xml-element    is xml-container('routes')            is rw; 
  has Str                     $.state                           is xml-element                                          is rw;   #=  pending | available | deleting | deleted
  has Tag                     @.tags                            is xml-element    is xml-container('tagSet')            is rw; 
  has Str                     $.transitGatewayId                is xml-element                                          is rw; 
  has Str                     $.type                            is xml-element                                          is rw;   #=  ipsec.1
  has VgwTelemetry            @.vgwTelemetry                    is xml-element    is xml-container('vgwTelemetry')      is rw; 
  has Str                     $.vpnConnectionId                 is xml-element                                          is rw; 
  has Str                     $.vpnGatewayId                    is xml-element                                          is rw; 
}