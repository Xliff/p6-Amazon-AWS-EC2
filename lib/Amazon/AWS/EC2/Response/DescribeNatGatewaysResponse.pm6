use v6.d;

use Amazon::AWS::Roles::Response;

use XML::Class;

use Amazon::AWS::EC2::Types::NatGateway;

class Amazon::AWS::EC2::Response::DescribeNatGatewaysResponse is export
  does XML::Class[xml-element => 'DescribeNatGatewaysResponse']
{
  also does Amazon::AWS::Roles::Response;

  has NatGateway        @.natGateways                    is xml-container('natGatewaySet')  is xml-skip-null is rw; 
  has Str               $.nextToken      is xml-element                                     is xml-skip-null is rw; 
  
  # Member aliases.
  method gateways         { @.natGateways }
}
