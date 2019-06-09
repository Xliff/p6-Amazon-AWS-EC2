use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;



class Amazon::AWS::EC2::Types::FlowLog is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Str    $.creationTime                is xml-element          is rw; 
  has Str    $.deliverLogsErrorMessage     is xml-element          is rw; 
  has Str    $.deliverLogsPermissionArn    is xml-element          is rw; 
  has Str    $.deliverLogsStatus           is xml-element          is rw; 
  has Str    $.flowLogId                   is xml-element          is rw; 
  has Str    $.flowLogStatus               is xml-element          is rw; 
  has Str    $.logDestination              is xml-element          is rw; 
  has Str    $.logDestinationType          is xml-element          is rw;   #=  cloud-watch-logs | s3
  has Str    $.logGroupName                is xml-element          is rw; 
  has Str    $.resourceId                  is xml-element          is rw; 
  has Str    $.trafficType                 is xml-element          is rw;   #=  ACCEPT | REJECT | ALL
}