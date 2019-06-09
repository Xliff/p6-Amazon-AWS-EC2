use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;

use Amazon::AWS::EC2::Types::UserBucketDetails;

class Amazon::AWS::EC2::Types::SnapshotTaskDetail is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Str                  $.description      is xml-element          is rw;
  has Num                  $.diskImageSize    is xml-element          is rw;
  has Bool                 $.encrypted        is xml-element          is rw;
  has Str                  $.format           is xml-element          is rw;
  has Str                  $.kmsKeyId         is xml-element          is rw;
  has Str                  $.progress         is xml-element          is rw;
  has Str                  $.snapshotId       is xml-element          is rw;
  has Str                  $.status           is xml-element          is rw;
  has Str                  $.statusMessage    is xml-element          is rw;
  has Str                  $.url              is xml-element          is rw;
  has UserBucketDetails    $.userBucket       is xml-element          is rw;
}
