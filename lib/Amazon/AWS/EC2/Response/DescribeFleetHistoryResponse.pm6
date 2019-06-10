use v6.d;

use Amazon::AWS::Roles::Response;

use XML::Class;

use Amazon::AWS::EC2::Types::HistoryRecordEntry;

class Amazon::AWS::EC2::Response::DescribeFleetHistoryResponse is export
  does XML::Class[xml-element => 'item']
{
  also does Amazon::AWS::Roles::Response;

  has Str                   $.fleetId              is xml-element                                              is rw; 
  has HistoryRecordEntry    @.historyRecords       is xml-element    is xml-container('historyRecordSet')      is rw; 
  has Str                   $.lastEvaluatedTime    is xml-element                                              is rw; 
  has Str                   $.nextToken            is xml-element                                              is rw; 
  has Str                   $.startTime            is xml-element                                              is rw; 
}