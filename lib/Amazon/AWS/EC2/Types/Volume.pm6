use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;

use Amazon::AWS::EC2::Types::Tag;
use Amazon::AWS::EC2::Types::VolumeAttachment;

class Amazon::AWS::EC2::Types::Volume is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has VolumeAttachment    @.attachments         is xml-element    is xml-skip-null    is xml-container('attachmentSet')      is rw; 
  has Str                 $.availabilityZone    is xml-element    is xml-skip-null                                           is rw; 
  has Str                 $.createTime          is xml-element    is xml-skip-null                                           is rw; 
  has Bool                $.encrypted           is xml-element    is xml-skip-null                                           is rw; 
  has Int                 $.iops                is xml-element    is xml-skip-null                                           is rw; 
  has Str                 $.kmsKeyId            is xml-element    is xml-skip-null                                           is rw; 
  has Int                 $.size                is xml-element    is xml-skip-null                                           is rw; 
  has Str                 $.snapshotId          is xml-element    is xml-skip-null                                           is rw; 
  has Str                 $.status              is xml-element    is xml-skip-null                                           is rw;   #=  creating | available | in-use | deleting | deleted | error
  has Tag                 @.tags                is xml-element    is xml-skip-null    is xml-container('tagSet')             is rw; 
  has Str                 $.volumeId            is xml-element    is xml-skip-null                                           is rw; 
  has Str                 $.volumeType          is xml-element    is xml-skip-null                                           is rw;   #=  standard | io1 | gp2 | sc1 | st1
}