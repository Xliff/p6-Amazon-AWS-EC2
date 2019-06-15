use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;

use Amazon::AWS::EC2::Types::UserBucket;

class Amazon::AWS::EC2::Types::ImageDiskContainer is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Str           $.Description    is xml-element    is xml-skip-null          is rw; 
  has Str           $.DeviceName     is xml-element    is xml-skip-null          is rw; 
  has Str           $.Format         is xml-element    is xml-skip-null          is rw; 
  has Str           $.SnapshotId     is xml-element    is xml-skip-null          is rw; 
  has Str           $.Url            is xml-element    is xml-skip-null          is rw; 
  has UserBucket    $.UserBucket     is xml-element    is xml-skip-null          is rw; 
}