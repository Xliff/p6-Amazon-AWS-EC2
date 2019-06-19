use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;

use Amazon::AWS::EC2::Types::ServiceTypeDetail;
use Amazon::AWS::EC2::Types::Tag;

class Amazon::AWS::EC2::Types::ServiceDetail is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Bool                 $.acceptanceRequired            is xml-element            is xml-skip-null                                                    is rw;
  has Str                  @.availabilityZones             is xml-element('item')    is xml-skip-null    is xml-container('availabilityZoneSet')         is rw;
  has Str                  @.baseEndpointDnsNames          is xml-element('item')    is xml-skip-null    is xml-container('baseEndpointDnsNameSet')      is rw;
  has Bool                 $.managesVpcEndpoints           is xml-element            is xml-skip-null                                                    is rw;
  has Str                  $.owner                         is xml-element            is xml-skip-null                                                    is rw;
  has Str                  $.privateDnsName                is xml-element            is xml-skip-null                                                    is rw;
  has Str                  $.serviceId                     is xml-element            is xml-skip-null                                                    is rw;
  has Str                  $.serviceName                   is xml-element            is xml-skip-null                                                    is rw;
  has ServiceTypeDetail    @.serviceType                                             is xml-skip-null    is xml-container('serviceTypeSet')              is rw; 
  has Tag                  @.tags                                                    is xml-skip-null    is xml-container('tagSet')                      is rw;
  has Bool                 $.vpcEndpointPolicySupported    is xml-element            is xml-skip-null                                                    is rw;
}
