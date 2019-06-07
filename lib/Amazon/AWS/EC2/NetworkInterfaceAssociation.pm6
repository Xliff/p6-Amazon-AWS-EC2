use v6.d;

use XML::Class;

use Amazon::AWS::EC2::Base;

class Amazon::AWS::EC2::NetworkInterfaceAssociation is export
  does XML::Class[xml-element => 'association']
{
  has Str $.allocationId  is xml-element is rw;
  has Str $.associationId is xml-element is rw;
  has Str $.ipOwnerId     is xml-element is rw;
  has Str $.publicDnsName is xml-element is rw;
  has Str $.publicIp      is xml-element is rw;
}
