use v6.d;

use XML::Class;

use Amazon::AWS::EC2::Types::Base;

class Amazon::AWS::EC2::Types::NetworkInterfaceAssociation is export
  does XML::Class[xml-element => 'association']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Str $.allocationId  is xml-element is rw;
  has Str $.associationId is xml-element is rw;
  has Str $.ipOwnerId     is xml-element is rw;
  has Str $.publicDnsName is xml-element is rw;
  has Str $.publicIp      is xml-element is rw;
}
