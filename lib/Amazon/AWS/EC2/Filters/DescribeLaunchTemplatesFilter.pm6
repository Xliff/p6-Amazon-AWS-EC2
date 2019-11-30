use v6.d;

use Amazon::AWS::Roles::Base;
use Amazon::AWS::Roles::Eqv;

use XML::Class;

class Amazon::AWS::EC2::Filters::DescribeLanuchTemplatesFilter::Tag 
  does XML::Class[xml-element => 'item']
{
  also does Amazon::AWS::Roles::Base;
  also does Amazon::AWS::Roles::Eqv;

  has Str                 $.key    is xml-element                             is xml-skip-null is rw;
  has Str                 $.value  is xml-element                             is xml-skip-null is rw;
}

constant Tag := Amazon::AWS::EC2::Filters::DescribeLanuchTemplatesFilter::Tag;

class Amazon::AWS::EC2::Filters::DescribeLaunchTemplatesFilter is export
  does XML::Class[xml-element => 'item']
{
  also does Amazon::AWS::Roles::Base;
  also does Amazon::AWS::Roles::Eqv;
  
  has Str $.create_time           is xml-element                              is xml-skip-null is rw;
  has Str $.launch-template-name  is xml-element                              is xml-skip-null is rw;
  has Tag @.tags                                  is xml-container('tagSet')  is xml-skip-null is rw;
  has Str $.tag-key               is xml-element                              is xml-skip-null is rw;
  
  method addTag ($name, $value) {
    @!tags.push: Tag.new(:$name, :$value);
  }
    
} 
