use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;

use Amazon::AWS::EC2::Types::NetworkInterfaceAssociation;

class Amazon::AWS::EC2::Types::NetworkInterfacePrivateIpAddress is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has NetworkInterfaceAssociation    $.association         is xml-element    is xml-skip-null          is rw; 
  has Bool                           $.primary             is xml-element    is xml-skip-null          is rw; 
  has Str                            $.privateDnsName      is xml-element    is xml-skip-null          is rw; 
  has Str                            $.privateIpAddress    is xml-element    is xml-skip-null          is rw; 
}