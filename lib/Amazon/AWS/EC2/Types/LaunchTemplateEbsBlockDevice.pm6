use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;



class Amazon::AWS::EC2::Types::LaunchTemplateEbsBlockDevice is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Bool    $.deleteOnTermination    is xml-element    is xml-skip-null          is rw; 
  has Bool    $.encrypted              is xml-element    is xml-skip-null          is rw; 
  has Int     $.iops                   is xml-element    is xml-skip-null          is rw; 
  has Str     $.kmsKeyId               is xml-element    is xml-skip-null          is rw; 
  has Str     $.snapshotId             is xml-element    is xml-skip-null          is rw; 
  has Int     $.volumeSize             is xml-element    is xml-skip-null          is rw; 
  has Str     $.volumeType             is xml-element    is xml-skip-null          is rw;   #=  standard | io1 | gp2 | sc1 | st1
}