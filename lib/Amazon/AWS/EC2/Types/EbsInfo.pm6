use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;

use Amazon::AWS::EC2::Types::EbsOptimizedInfo;

class Amazon::AWS::EC2::Types::EbsInfo is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has EbsOptimizedInfo    $.ebsOptimizedInfo       is xml-element(:over-ride)    is xml-skip-null          is rw;
  has Str                 $.ebsOptimizedSupport    is xml-element                is xml-skip-null          is rw;   #=  unsupported | supported | default
  has Str                 $.encryptionSupport      is xml-element                is xml-skip-null          is rw;   #=  unsupported | supported
  has Str                 $.nvmeSupport            is xml-element                is xml-skip-null          is rw;   #=  unsupported | supported | required
}
