use v6.d;

use Amazon::AWS::Roles::Response;

use XML::Class;

use Amazon::AWS::EC2::Types::DhcpOptions;

class Amazon::AWS::EC2::Response::DescribeDhcpOptionsResponse is export
  does XML::Class[xml-element => 'DescribeDhcpOptionsResponse']
{
  also does Amazon::AWS::Roles::Response;

  has DhcpOptions        @.DhcpOptions    is xml-element    is xml-container('dhcpOptionSet') is xml-skip-null is rw; 
  has Str                $.nextToken      is xml-element                                      is xml-skip-null is rw; 
  
  # Member aliases.
  method options         { @.DhcpOptions }
}
