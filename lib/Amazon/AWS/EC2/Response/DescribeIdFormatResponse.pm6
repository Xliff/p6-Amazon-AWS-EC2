use v6.d;

use Amazon::AWS::Roles::Response;

use XML::Class;

use Amazon::AWS::EC2::Types::IdFormat;

class Amazon::AWS::EC2::Response::DescribeIdFormatResponse is export
  does XML::Class[xml-element => 'DescribeIdFormatResponse']
{
  also does Amazon::AWS::Roles::Response;

  has IdFormat    @.status    is xml-container('statusSet')    is rw;
}
