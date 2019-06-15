use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;



class Amazon::AWS::EC2::Types::VpnTunnelOptionsSpecification is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Str    $.PreSharedKey        is xml-element    is xml-skip-null          is rw; 
  has Str    $.TunnelInsideCidr    is xml-element    is xml-skip-null          is rw; 
}