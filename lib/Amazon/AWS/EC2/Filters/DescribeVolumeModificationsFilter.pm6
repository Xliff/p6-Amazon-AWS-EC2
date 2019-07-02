use v6.d;

use Amazon::AWS::Roles::Base;
use Amazon::AWS::Roles::Eqv;

use Amazon::AWS::Utils;

use XML::Class;

my %attributes;

class Amazon::AWS::EC2::Filters::DescribeVolumeModificationsFilter is export
  does XML::Class[xml-element => 'item']
{
  also does Amazon::AWS::Roles::Base;
  also does Amazon::AWS::Roles::Eqv;
  
  has Str $.volume-id                          is xml-element is xml-skip-null is rw; 
  has Str $.modification-state                 is xml-element is xml-skip-null is rw;  #=  modifying | optimizing | completed | failed
  has Int $.target-size                        is xml-element is xml-skip-null is rw;
  has Int $.target-iops                        is xml-element is xml-skip-null is rw;
  has Str $.target-volume-type                 is xml-element is xml-skip-null is rw;  #=  standard | io1 | gp2 | sc1 | st1
  has Int $.original-target-size               is xml-element is xml-skip-null is rw;
  has Int $.original-target-iops               is xml-element is xml-skip-null is rw;
  has Str $.original-target-volume-type        is xml-element is xml-skip-null is rw;  #=  standard | io1 | gp2 | sc1 | st1
  has Str $.start-time                         is xml-element is xml-skip-null is rw;
} 

# For direct access to any Attribute metadata.
BEGIN {
  %attributes = getAttributeData(
    Amazon::AWS::EC2::Filters::DescribeVolumeModificationsFilter
  )
}
