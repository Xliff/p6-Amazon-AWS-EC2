use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;

use Amazon::AWS::EC2::Types::FpgaImageState;
use Amazon::AWS::EC2::Types::PciId;
use Amazon::AWS::EC2::Types::ProductCode;
use Amazon::AWS::EC2::Types::Tag;

class Amazon::AWS::EC2::Types::FpgaImage is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Str               $.createTime              is xml-element                is xml-skip-null                                          is rw;
  has Bool              $.dataRetentionSupport    is xml-element                is xml-skip-null                                          is rw;
  has Str               $.description             is xml-element                is xml-skip-null                                          is rw;
  has Str               $.fpgaImageGlobalId       is xml-element                is xml-skip-null                                          is rw;
  has Str               $.fpgaImageId             is xml-element                is xml-skip-null                                          is rw;
  has Str               $.name                    is xml-element                is xml-skip-null                                          is rw;
  has Str               $.ownerAlias              is xml-element                is xml-skip-null                                          is rw;
  has Str               $.ownerId                 is xml-element                is xml-skip-null                                          is rw;
  has PciId             $.pciId                   is xml-element(:over-ride)    is xml-skip-null                                          is rw;
  has ProductCode       @.productCodes                                          is xml-skip-null    is xml-container('productCodes')      is rw;
  has Bool              $.public                  is xml-element                is xml-skip-null                                          is rw;
  has Str               $.shellVersion            is xml-element                is xml-skip-null                                          is rw;
  has FpgaImageState    $.state                   is xml-element(:over-ride)    is xml-skip-null                                          is rw;
  has Tag               @.tags                                                  is xml-skip-null    is xml-container('tags')              is rw;
  has Str               $.updateTime              is xml-element                is xml-skip-null                                          is rw;
}
