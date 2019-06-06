use v6.d;

use Amazon::AWS::EC2::Base;

use XML::Class;

class Amazon::AWS::EC2::InstanceNetworkInterfaceAssociation is export
  does XML::Class[xml-element => 'association']
{
  also is Amazon::AWS::EC2::Base;

  has Str $.ipOwnerId     is xml-element is rw;
  has Str $.publicDnsName is xml-element is rw;
  has Str $.publicIp      is xml-element is rw;
}