use v6.d;

use Amazon::AWS::Roles::Response;

use XML::Class;

use Amazon::AWS::EC2::Types::Snapshot;

class Amazon::AWS::EC2::Response::DescribeSnapshotsResponse is export
  does XML::Class[xml-element => 'DescribeSnapshotsResponse']
{
  also does Amazon::AWS::Roles::Response;

  has Str         $.nextToken    is xml-element                                                         is rw;
  has Snapshot    @.snapshots    is xml-element('item', :over-ride)  is xml-container('snapshotSet')    is rw;
}
