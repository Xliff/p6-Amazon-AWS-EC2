use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;

use Amazon::AWS::EC2::Types::Tag;

class Amazon::AWS::EC2::Types::Snapshot is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Str     $.dataEncryptionKeyId    is xml-element    is xml-skip-null                                    is rw; 
  has Str     $.description            is xml-element    is xml-skip-null                                    is rw; 
  has Bool    $.encrypted              is xml-element    is xml-skip-null                                    is rw; 
  has Str     $.kmsKeyId               is xml-element    is xml-skip-null                                    is rw; 
  has Str     $.ownerAlias             is xml-element    is xml-skip-null                                    is rw; 
  has Str     $.ownerId                is xml-element    is xml-skip-null                                    is rw; 
  has Str     $.progress               is xml-element    is xml-skip-null                                    is rw; 
  has Str     $.snapshotId             is xml-element    is xml-skip-null                                    is rw; 
  has Str     $.startTime              is xml-element    is xml-skip-null                                    is rw; 
  has Str     $.status                 is xml-element    is xml-skip-null                                    is rw;   #=  pending | completed | error
  has Str     $.statusMessage          is xml-element    is xml-skip-null                                    is rw; 
  has Tag     @.tags                   is xml-element    is xml-skip-null    is xml-container('tagSet')      is rw; 
  has Str     $.volumeId               is xml-element    is xml-skip-null                                    is rw; 
  has Int     $.volumeSize             is xml-element    is xml-skip-null                                    is rw; 
}