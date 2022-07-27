use v6.d;

use Amazon::AWS::Utils;

use Amazon::AWS::Roles::Response;

use XML::Class;

my %attributes;

class Amazon::AWS::EC2::Response::ModifyVolumeResponse is export
  does XML::Class[xml-element => 'ModifyVolumeResponse']
{
  also does Amazon::AWS::Roles::Response;

  has Bool $.dryRun                        is xml-element  is xml-skip-null is rw;
  has Str  $.endTime                       is xml-element  is xml-skip-null is rw;
  has Str  $.modificationState             is xml-element  is xml-skip-null is rw;  #= modifying | optimizing | completed | failed
  has Int  $.originalIops                  is xml-element  is xml-skip-null is rw;
  has Bool $.originalMultiAttachEnabled    is xml-element  is xml-skip-null is rw;
  has Int  $.originalSize                  is xml-element  is xml-skip-null is rw;
  has Str  $.originalThroughput            is xml-element  is xml-skip-null is rw;
  has Str  $.originalVolumeType            is xml-element  is xml-skip-null is rw;  #=  standard | io1 | gp2 | sc1 | st1 | gp3
  has Int  $.progress                      is xml-element  is xml-skip-null is rw;
  has Str  $.startTime                     is xml-element  is xml-skip-null is rw;
  has Str  $.statusMessage                 is xml-element  is xml-skip-null is rw;
  has Int  $.targetIops                    is xml-element  is xml-skip-null is rw;
  has Bool $.targetMultiAttachEnabled      is xml-element  is xml-skip-null is rw;
  has Str  $.targetThroughput              is xml-element  is xml-skip-null is rw;
  has Int  $.targetSize                    is xml-element  is xml-skip-null is rw;
  has Str  $.targetVolumeType              is xml-element  is xml-skip-null is rw;  #=  standard | io1 | gp2 | sc1 | st1 | gp3
  has Str  $.volumeId                      is xml-element  is xml-skip-null is rw;

  method getValidModificationStates {
    %attributes<modificationState|ValidValues>.Array;
  }

  method getValidOriginalVolumeTypes {
    %attributes<originalVolumeType|ValidValues>.Array;
  }

  method getValidTargetVolumeTypes {
    %attributes<targetVolumeType|ValidValues>.Array;
  }

}

BEGIN {
  %attributes = getAttributeData(
    Amazon::AWS::EC2::Response::ModifyVolumeResponse
  );
}
