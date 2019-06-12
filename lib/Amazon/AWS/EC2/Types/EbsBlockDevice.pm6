use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;



class Amazon::AWS::EC2::Types::EbsBlockDevice is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Bool    $.DeleteOnTermination    is xml-element          is rw;
  has Bool    $.deleteOnTermination    is xml-element          is rw;
  has Bool    $.Encrypted              is xml-element          is rw;
  has Bool    $.encrypted              is xml-element          is rw;
  has Int     $.Iops                   is xml-element          is rw;
  has Int     $.iops                   is xml-element          is rw;
  has Str     $.KmsKeyId               is xml-element          is rw;
  has Str     $.kmsKeyId               is xml-element          is rw;
  has Str     $.SnapshotId             is xml-element          is rw;
  has Str     $.snapshotId             is xml-element          is rw;
  has Int     $.VolumeSize             is xml-element          is rw;
  has Int     $.volumeSize             is xml-element          is rw;
  has Str     $.VolumeType             is xml-element          is rw;   #=  standard | io1 | gp2 | sc1 | st1
  has Str     $.volumeType             is xml-element          is rw;   #=  standard | io1 | gp2 | sc1 | st1
}
