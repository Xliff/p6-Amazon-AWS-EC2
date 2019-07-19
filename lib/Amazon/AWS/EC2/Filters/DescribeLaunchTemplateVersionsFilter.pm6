use v6.d;

use Amazon::AWS::Roles::Base;
use Amazon::AWS::Roles::Eqv;

use XML::Class;

class Amazon::AWS::EC2::Filters::DescribeLaunchTemplateVersionsFilter is export
  does XML::Class[xml-element => 'item']
{
  also does Amazon::AWS::Roles::Base;
  also does Amazon::AWS::Roles::Eqv;
  
  has Str  $.create_time           is xml-element is xml-skip-null is rw;
  has Str  $.ebs-optimized         is xml-element is xml-skip-null is rw;
  has Str  $.iam-instance-profile  is xml-element is xml-skip-null is rw;
  has Str  $.image-id              is xml-element is xml-skip-null is rw;
  has Str  $.instance-type         is xml-element is xml-skip-null is rw;
  has Bool $.is-default-version    is xml-element is xml-skip-null is rw;
  has Str  $.kernel-id             is xml-element is xml-skip-null is rw;
  has Str  $.ram-disk-id           is xml-element is xml-skip-null is rw;
} 
