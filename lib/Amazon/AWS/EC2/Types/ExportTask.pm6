use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;

use Amazon::AWS::EC2::Types::ExportToS3Task;
use Amazon::AWS::EC2::Types::InstanceExportDetails;

class Amazon::AWS::EC2::Types::ExportTask is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Str                      $.description       is xml-element                is xml-skip-null          is rw; 
  has Str                      $.exportTaskId      is xml-element                is xml-skip-null          is rw; 
  has ExportToS3Task           $.exportToS3        is xml-element(:over-ride)    is xml-skip-null          is rw;
  has InstanceExportDetails    $.instanceExport    is xml-element(:over-ride)    is xml-skip-null          is rw;
  has Str                      $.state             is xml-element                is xml-skip-null          is rw;   #=  active | cancelling | cancelled | completed
  has Str                      $.statusMessage     is xml-element                is xml-skip-null          is rw;
}
