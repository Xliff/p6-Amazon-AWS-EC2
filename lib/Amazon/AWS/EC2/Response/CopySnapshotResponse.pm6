use v6.d;

use Amazon::AWS::Roles::Response;

use XML::Class;

class Amazon::AWS::EC2::Response::CopySnapshotResponse is export
  does XML::Class[xml-element => 'CopySnapshotResponse']
{
  also does Amazon::AWS::Roles::Response;

  has Str    $.snapshotId    is xml-element is xml-skip-null is rw; 
}
