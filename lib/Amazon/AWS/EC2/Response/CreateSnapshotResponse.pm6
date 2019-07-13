use v6.d;

use Amazon::AWS::Roles::Response;

use XML::Class;

use Amazon::AWS::EC2::Types::Tag;

class Amazon::AWS::EC2::Response::CreateSnapshotResponse is export
  does XML::Class[xml-element => 'CreateSnapshotResponse']
{
  also does Amazon::AWS::Roles::Response;

  has Str   $.description                                is xml-element  is xml-skip-null is rw; 
  has Bool  $.encrypted                                  is xml-element  is xml-skip-null is rw; 
  has Str   $.kmsKeyId                                   is xml-element  is xml-skip-null is rw; 
  has Str   $.owner-alias                                is xml-element  is xml-skip-null is rw;  #=  amazon | self | all | aws-marketplace | microsoft
  has Str   $.ownerId                                    is xml-element  is xml-skip-null is rw; 
  has Int   $.progress                                   is xml-element  is xml-skip-null is rw; 
  has Str   $.snapshotId                                 is xml-element  is xml-skip-null is rw; 
  has Str   $.startTime                                  is xml-element  is xml-skip-null is rw; 
  has Str   $.status                                     is xml-element  is xml-skip-null is rw;  #=  pending | completed | error
  has Str   $.statusMessage                              is xml-element  is xml-skip-null is rw;  
  has Tag   @.tags           is xml-container('tagSet')                  is xml-skip-null is rw; 
  has Str   $.volumeId                                   is xml-element  is xml-skip-null is rw; 
  has Int   $.volumeSize                                 is xml-element  is xml-skip-null is rw; 
}
