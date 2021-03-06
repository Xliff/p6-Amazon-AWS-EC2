use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;



class Amazon::AWS::EC2::Types::InstanceNetworkInterfaceAssociation is export
  does XML::Class
{
  also is Amazon::AWS::EC2::Types::Base;

  has Str    $.ipOwnerId        is xml-element    is xml-skip-null          is rw;
  has Str    $.publicDnsName    is xml-element    is xml-skip-null          is rw;
  has Str    $.publicIp         is xml-element    is xml-skip-null          is rw;
}
