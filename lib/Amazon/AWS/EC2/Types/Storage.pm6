use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;

use Amazon::AWS::EC2::Types::S3Storage;

class Amazon::AWS::EC2::Types::Storage is export
  does XML::Class
{
  also is Amazon::AWS::EC2::Types::Base;

  has S3Storage    $.S3    is xml-element(:over-ride)    is xml-skip-null          is rw;
  #has S3Storage    $.S3    is xml-element(:over-ride)    is xml-skip-null          is rw;
}
