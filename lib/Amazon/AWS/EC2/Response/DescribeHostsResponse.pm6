use v6.d;

use Amazon::AWS::Roles::Response;

use XML::Class;

use Amazon::AWS::EC2::Types::Host;

class Amazon::AWS::EC2::Response::DescribeHostsResponse is export
  does XML::Class[xml-element => 'item']
{
  also does Amazon::AWS::Roles::Response;

  has Host    @.hosts        is xml-element    is xml-container('hostSet')      is rw; 
  has Str     $.nextToken    is xml-element                                     is rw; 
}