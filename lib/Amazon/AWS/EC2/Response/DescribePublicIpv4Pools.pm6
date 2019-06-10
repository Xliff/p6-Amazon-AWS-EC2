use v6.d;

use Amazon::AWS::Roles::Response;

use XML::Class;

use Amazon::AWS::EC2::Types::PublicIpv4Pool;

class Amazon::AWS::EC2::Types::Response::DescribePublicIpv4PoolsResponse is export
  does XML::Class[xml-element => 'item']
{
  also does Amazon::AWS::Roles::Response;

  has Str               $.nextToken          is xml-element                                               is rw; 
  has PublicIpv4Pool    @.publicIpv4Pools    is xml-element    is xml-container('publicIpv4PoolSet')      is rw; 
}