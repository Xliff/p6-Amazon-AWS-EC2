use v6.d;

use Amazon::AWS::Roles::Base;
use Amazon::AWS::Roles::Eqv;

use Amazon::AWS::Utils;

use XML::Class;

my %attributes;

class Amazon::AWS::EC2::Filters::DescribeSnapshotsFilter::Tag
  does XML::Class[xml-element => 'item']
{
  also does Amazon::AWS::Roles::Base;
  also does Amazon::AWS::Roles::Eqv;

  has Str                 $.key                           is xml-element is xml-skip-null is rw;
  has Str                 $.value                         is xml-element is xml-skip-null is rw;
}

constant Tag := Amazon::AWS::EC2::Filters::DescribeSnapshotsFilter::Tag;

class Amazon::AWS::EC2::Filters::DescribeSnapshotsFilter is export
  does XML::Class[xml-element => 'item']
{
  also does Amazon::AWS::Roles::Base;
  also does Amazon::AWS::Roles::Eqv;
  
  has Str  $.descsription                                 is xml-element is xml-skip-null is rw;
  has Bool $.encrypted                                    is xml-element is xml-skip-null is rw;
  has Str  $.owner-alias                                  is xml-element is xml-skip-null is rw;  #= amazon | self | all | aws-marketplace | microsoft
  has Str  $.progress                                     is xml-element is xml-skip-null is rw;
  has Str  $.snapshot-id                                  is xml-element is xml-skip-null is rw;
  has Str  $.start-time                                   is xml-element is xml-skip-null is rw;  
  has Str  $.status                                       is xml-element is xml-skip-null is rw;  #= pending | completed | error
  has Str  $.volume-id                                    is xml-element is xml-skip-null is rw;
  has Tag  @.tags           is xml-container('tagSet')                   is xml-skip-null is rw;
  has Int  $.volume-size                                  is xml-element is xml-skip-null is rw;  
  
  method getOwnerAliases {
    %attributes<Owner-Alias|ValidValues>.Array
  }
  
  method getValidStatusValues {
    %attributes<Status|ValidValues>.Array
  }
  
  # XXX - get/set attribute methods for status and owner-alias
} 

# For direct access to any Attribute metadata.
BEGIN {
  %attributes = getAttributeData(
    Amazon::AWS::EC2::Filters::DescribeSnapshotsFilter
  )
}
