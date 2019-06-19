use v6.d;

use Amazon::AWS::Roles::Response;

use XML::Class;

use Amazon::AWS::EC2::Types::HistoryRecord;

class Amazon::AWS::EC2::Response::DescribeSpotFleetRequestHistoryResponse is export
  does XML::Class[xml-element => 'DescribeSpotFleetRequestHistoryResponse']
{
  also does Amazon::AWS::Roles::Response;

  has HistoryRecord    @.historyRecords        is xml-element    is xml-container('historyRecordSet')      is rw; 
  has Str              $.lastEvaluatedTime     is xml-element                                              is rw; 
  has Str              $.nextToken             is xml-element                                              is rw; 
  has Str              $.spotFleetRequestId    is xml-element                                              is rw; 
  has Str              $.startTime             is xml-element                                              is rw; 
}