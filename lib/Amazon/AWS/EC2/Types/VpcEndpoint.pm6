use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;

use Amazon::AWS::EC2::Types::DnsEntry;
use Amazon::AWS::EC2::Types::SecurityGroupIdentifier;
use Amazon::AWS::EC2::Types::Tag;

class Amazon::AWS::EC2::Types::VpcEndpoint is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Str                        $.creationTimestamp      is xml-element    is xml-skip-null                                                   is rw; 
  has DnsEntry                   @.dnsEntrys              is xml-element    is xml-skip-null    is xml-container('dnsEntrySet')                is rw; 
  has SecurityGroupIdentifier    @.groups                 is xml-element    is xml-skip-null    is xml-container('groupSet')                   is rw; 
  has Str                        @.networkInterfaceIds    is xml-element    is xml-skip-null    is xml-container('networkInterfaceIdSet')      is rw; 
  has Str                        $.ownerId                is xml-element    is xml-skip-null                                                   is rw; 
  has Str                        $.policyDocument         is xml-element    is xml-skip-null                                                   is rw; 
  has Bool                       $.privateDnsEnabled      is xml-element    is xml-skip-null                                                   is rw; 
  has Bool                       $.requesterManaged       is xml-element    is xml-skip-null                                                   is rw; 
  has Str                        @.routeTableIds          is xml-element    is xml-skip-null    is xml-container('routeTableIdSet')            is rw; 
  has Str                        $.serviceName            is xml-element    is xml-skip-null                                                   is rw; 
  has Str                        $.state                  is xml-element    is xml-skip-null                                                   is rw;   #=  PendingAcceptance | Pending | Available | Deleting | Deleted | Rejected | Failed | Expired
  has Str                        @.subnetIds              is xml-element    is xml-skip-null    is xml-container('subnetIdSet')                is rw; 
  has Tag                        @.tags                   is xml-element    is xml-skip-null    is xml-container('tagSet')                     is rw; 
  has Str                        $.vpcEndpointId          is xml-element    is xml-skip-null                                                   is rw; 
  has Str                        $.vpcEndpointType        is xml-element    is xml-skip-null                                                   is rw;   #=  Interface | Gateway
  has Str                        $.vpcId                  is xml-element    is xml-skip-null                                                   is rw; 
}