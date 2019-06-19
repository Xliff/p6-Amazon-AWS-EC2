use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;

use Amazon::AWS::EC2::Types::DnsEntry;

class Amazon::AWS::EC2::Types::VpcEndpointConnection is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Str         $.creationTimestamp          is xml-element    is xml-skip-null                                                       is rw; 
  has DnsEntry    @.dnsEntrys                  is xml-element    is xml-skip-null    is xml-container('dnsEntrySet')                    is rw; 
  has Str         @.networkLoadBalancerArns    is xml-element    is xml-skip-null    is xml-container('networkLoadBalancerArnSet')      is rw; 
  has Str         $.serviceId                  is xml-element    is xml-skip-null                                                       is rw; 
  has Str         $.vpcEndpointId              is xml-element    is xml-skip-null                                                       is rw; 
  has Str         $.vpcEndpointOwner           is xml-element    is xml-skip-null                                                       is rw; 
  has Str         $.vpcEndpointState           is xml-element    is xml-skip-null                                                       is rw;   #=  PendingAcceptance | Pending | Available | Deleting | Deleted | Rejected | Failed | Expired
}