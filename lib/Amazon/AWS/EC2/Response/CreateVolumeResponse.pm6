use v6.d;

use Amazon::AWS::Utils;

use Amazon::AWS::Roles::Response;

use XML::Class;

use Amazon::AWS::EC2::Types::VolumeAttachment;
use Amazon::AWS::EC2::Types::Tag;

my %attributes;

class Amazon::AWS::EC2::Response::CreateVolumeResponse is export
  does XML::Class[xml-element => 'CreateVolumeResponse']
{
  also does Amazon::AWS::Roles::Response;
  
  has VolumeAttachment  @.attachments          is xml-container('attachmentSet')                       is xml-skip-null is rw;
  has Str               $.availabilityZone                                             is xml-element  is xml-skip-null is rw;
  has Bool              $.dryRun                                                       is xml-element  is xml-skip-null is rw;
  has Str               $.createTime                                                   is xml-element  is xml-skip-null is rw;
  has Bool              $.encrypted                                                    is xml-element  is xml-skip-null is rw;
  has Int               $.iops                                                         is xml-element  is xml-skip-null is rw;
  has Str               $.kmsKeyId                                                     is xml-element  is xml-skip-null is rw;
  has Int               $.size                                                         is xml-element  is xml-skip-null is rw;
  has Str               $.snapshotId                                                   is xml-element  is xml-skip-null is rw;
  has Str               $.status                                                       is xml-element  is xml-skip-null is rw;  #=  creating | available | in-use | deleting | deleted | error
  has Tag               @.tags                 is xml-container('tagSet')                              is xml-skip-null is rw;
  has Str               $.volumeId                                                     is xml-element  is xml-skip-null is rw; 
  has Str               $.volumeType                                                   is xml-element  is xml-skip-null is rw;  #=  standard | io1 | gp2 | sc1 | st1  
  has Int               $.volumeSize                                                   is xml-element  is xml-skip-null is rw; 
  
  method getValidVolumeTypes {
    %attributes<volumeType|ValidValues>.Array;
  }
  
  method getValidStatus {
    %attributes<status|ValidValues>.Array;
  }
    
}

BEGIN {
  %attributes = getAttributeData(
    Amazon::AWS::EC2::Response::CreateVolumeResponse
  );
}
