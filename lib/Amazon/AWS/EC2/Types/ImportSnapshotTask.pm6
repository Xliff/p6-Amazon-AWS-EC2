use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;

use Amazon::AWS::EC2::Types::SnapshotTaskDetail;

class Amazon::AWS::EC2::Types::ImportSnapshotTask is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Str                   $.description           is xml-element    is xml-skip-null          is rw; 
  has Str                   $.importTaskId          is xml-element    is xml-skip-null          is rw; 
  has SnapshotTaskDetail    $.snapshotTaskDetail    is xml-element    is xml-skip-null          is rw; 
}