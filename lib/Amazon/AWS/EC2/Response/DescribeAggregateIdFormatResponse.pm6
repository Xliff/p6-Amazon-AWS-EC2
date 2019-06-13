use v6.d;

use Amazon::AWS::Roles::Response;

use XML::Class;

use Amazon::AWS::EC2::Types::IdFormat;

class Amazon::AWS::EC2::Response::DescribeAggregateIdFormatResponse is export
  does XML::Class[xml-element => 'item']
{
  also does Amazon::AWS::Roles::Response;

  has IdFormat    @.statuss                 is xml-element    is xml-container('statusSet')      is rw; 
  has Bool        $.useLongIdsAggregated    is xml-element                                       is rw; 
}