use v6.d;

use Amazon::AWS::Roles::Response;

use XML::Class;

use Amazon::AWS::EC2::Types::RouteTable;

class Amazon::AWS::EC2::Response::DescribeRouteTablesResponse is export
  does XML::Class[xml-element => 'DescribeRouteTablesResponse']
{
  also does Amazon::AWS::Roles::Response;

  has RouteTable    @.routes        is xml-container('routeTableSet')                 is xml-skip-null is rw; 
  has Str           $.nextToken                                        is xml-element is xml-skip-null is rw; 
}
