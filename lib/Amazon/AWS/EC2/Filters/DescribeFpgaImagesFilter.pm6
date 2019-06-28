use v6.d;

use Amazon::AWS::Roles::Base;
use Amazon::AWS::Roles::Eqv;

use XML::Class;

class Amazon::AWS::EC2::Filters::DescribeFpgaImagesFilter::Tag
  does XML::Class[xml-element => 'item']
{
  also does Amazon::AWS::Roles::Base;
  also does Amazon::AWS::Roles::Eqv;

  has Str    $.key      is xml-element is xml-skip-null is rw;
  has Str    $.value    is xml-element is xml-skip-null is rw;
}

constant Tag := Amazon::AWS::EC2::Filters::DescribeFpgaImagesFilter::Tag;

class Amazon::AWS::EC2::Filters::DescribeFpgaImagesFilter is export
  does XML::Class[xml-element => 'item']
{
  also does Amazon::AWS::Roles::Base;
  also does Amazon::AWS::Roles::Eqv;
  
  has Str  $.create-time                        is xml-element is xml-skip-null is rw;
  has Str  $.fpga-image-id                      is xml-element is xml-skip-null is rw;
  has Str  $.fpa-image-global-id                is xml-element is xml-skip-null is rw;
  has Str  $.name                               is xml-element is xml-skip-null is rw;
  has Str  $.owner-id                           is xml-element is xml-skip-null is rw;
  has Str  $.product-code                       is xml-element is xml-skip-null is rw;
  has Str  $.shell-version                      is xml-element is xml-skip-null is rw;
  has Str  $.state                              is xml-element is xml-skip-null is rw;
  has Tag  @.tags is xml-container('tagSet')                   is xml-skip-null is rw;
  has Str  $.tag-key                            is xml-element is xml-skip-null is rw;
  has Str  $.update-time                        is xml-element is xml-skip-null is rw;
} 
