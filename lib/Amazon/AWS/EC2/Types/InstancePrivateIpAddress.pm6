use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;

use Amazon::AWS::EC2::Types::InstanceNetworkInterfaceAssociation;

class Amazon::AWS::EC2::Types::InstancePrivateIpAddress is export
  does XML::Class
{
  also is Amazon::AWS::EC2::Types::Base;

  has InstanceNetworkInterfaceAssociation    $.association         is xml-element(:over-ride)    is xml-skip-null          is rw;
  has Bool                                   $.primary             is xml-element                is xml-skip-null          is rw;
  has Str                                    $.privateDnsName      is xml-element                is xml-skip-null          is rw;
  has Str                                    $.privateIpAddress    is xml-element                is xml-skip-null          is rw;
}
