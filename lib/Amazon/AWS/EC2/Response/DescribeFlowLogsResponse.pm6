use v6.d;

use Amazon::AWS::Roles::Response;

use XML::Class;

use Amazon::AWS::EC2::Types::FlowLog;

class Amazon::AWS::EC2::Response::DescribeFlowLogsResponse is export
  does XML::Class[xml-element => 'DescribeFlowLogsResponse']
{
  also does Amazon::AWS::Roles::Response;

  has FlowLog    @.logs                           is xml-container('flowLogSet')    is xml-skip-null is rw; 
  has Str        $.fleetId      is xml-element                                      is xml-skip-null is rw; 
  has Str        $.nextToken    is xml-element                                      is xml-skip-null is rw; 
}
