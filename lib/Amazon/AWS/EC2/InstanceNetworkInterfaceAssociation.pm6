use v6.d;

use XML::Class;

class Amazon::AWS::EC2::InstanceNetworkInterfaceAssociation is export
  does XML::Class[xml-element => 'association']
{
  has Str $.ipOwnerId     is xml-element is rw;
  has Str $.publicDnsName is xml-element is rw;
  has Str $.publicIp      is xml-element is rw;
}
