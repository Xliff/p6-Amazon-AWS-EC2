use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;



class Amazon::AWS::EC2::Types::ScheduledInstancesEbs is export
  does XML::Class
{
  also is Amazon::AWS::EC2::Types::Base;

  has Bool    $.DeleteOnTermination    is xml-element    is xml-skip-null          is rw;
  has Bool    $.Encrypted              is xml-element    is xml-skip-null          is rw;
  has Int     $.Iops                   is xml-element    is xml-skip-null          is rw;
  has Str     $.SnapshotId             is xml-element    is xml-skip-null          is rw;
  has Int     $.VolumeSize             is xml-element    is xml-skip-null          is rw;
  has Str     $.VolumeType             is xml-element    is xml-skip-null          is rw;
}
