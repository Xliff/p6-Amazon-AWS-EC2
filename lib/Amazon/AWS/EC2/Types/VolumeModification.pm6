use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;



class Amazon::AWS::EC2::Types::VolumeModification is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Str    $.endTime               is xml-element    is xml-skip-null          is rw; 
  has Str    $.modificationState     is xml-element    is xml-skip-null          is rw;   #=  modifying | optimizing | completed | failed
  has Int    $.originalIops          is xml-element    is xml-skip-null          is rw; 
  has Int    $.originalSize          is xml-element    is xml-skip-null          is rw; 
  has Str    $.originalVolumeType    is xml-element    is xml-skip-null          is rw;   #=  standard | io1 | gp2 | sc1 | st1
  has Int    $.progress              is xml-element    is xml-skip-null          is rw; 
  has Str    $.startTime             is xml-element    is xml-skip-null          is rw; 
  has Str    $.statusMessage         is xml-element    is xml-skip-null          is rw; 
  has Int    $.targetIops            is xml-element    is xml-skip-null          is rw; 
  has Int    $.targetSize            is xml-element    is xml-skip-null          is rw; 
  has Str    $.targetVolumeType      is xml-element    is xml-skip-null          is rw;   #=  standard | io1 | gp2 | sc1 | st1
  has Str    $.volumeId              is xml-element    is xml-skip-null          is rw; 
}