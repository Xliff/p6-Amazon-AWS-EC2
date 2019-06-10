use v6.d;

use Amazon::AWS::Roles::Response;

use XML::Class;

use Amazon::AWS::EC2::Types::ByoipCidr;

class Amazon::AWS::EC2::Types::Response::DescribeByoipCidrsResponse is export
  does XML::Class[xml-element => 'item']
{
  also does Amazon::AWS::Roles::Response;

  has ByoipCidr    @.byoipCidrs    is xml-element    is xml-container('byoipCidrSet')      is rw; 
  has Str          $.nextToken     is xml-element                                          is rw; 
}