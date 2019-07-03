use v6.d;

use Amazon::AWS::Roles::Response;

use XML::Class;

use Amazon::AWS::EC2::Types::Vpc;

class Amazon::AWS::EC2::Response::DescribeVpcsResponse is export
  does XML::Class[xml-element => 'DescribeVpcsResponse']
{
  also does Amazon::AWS::Roles::Response;

  has Vpc               @.tags                       is xml-container('tagSet')  is xml-skip-null is rw;
  has Str               $.nextToken  is xml-element                              is xml-skip-null is rw;
}
