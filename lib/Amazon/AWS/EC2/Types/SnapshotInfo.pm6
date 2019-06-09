use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;

use Amazon::AWS::EC2::Types::Tag;

class Amazon::AWS::EC2::Types::SnapshotInfo is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Str     $.description    is xml-element                                    is rw; 
  has Bool    $.encrypted      is xml-element                                    is rw; 
  has Str     $.ownerId        is xml-element                                    is rw; 
  has Str     $.progress       is xml-element                                    is rw; 
  has Str     $.snapshotId     is xml-element                                    is rw; 
  has Str     $.startTime      is xml-element                                    is rw; 
  has Str     $.state          is xml-element                                    is rw;   #=  pending | completed | error
  has Tag     @.tags           is xml-element    is xml-container('tagSet')      is rw; 
  has Str     $.volumeId       is xml-element                                    is rw; 
  has Int     $.volumeSize     is xml-element                                    is rw; 
}