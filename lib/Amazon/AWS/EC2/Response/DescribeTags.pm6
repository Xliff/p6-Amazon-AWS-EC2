use v6.d;

use Amazon::AWS::Roles::Response;

use XML::Class;

use Amazon::AWS::EC2::Types::TagDescription;

class Amazon::AWS::EC2::Types::Response::DescribeTagsResponse is export
  does XML::Class[xml-element => 'item']
{
  also does Amazon::AWS::Roles::Response;

  has Str               $.nextToken    is xml-element                                    is rw; 
  has TagDescription    @.tags         is xml-element    is xml-container('tagSet')      is rw; 
}