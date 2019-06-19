use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;



class Amazon::AWS::EC2::Types::ExportToS3Task is export
  does XML::Class
{
  also is Amazon::AWS::EC2::Types::Base;

  has Str    $.containerFormat    is xml-element    is xml-skip-null          is rw;   #=  ova
  has Str    $.diskImageFormat    is xml-element    is xml-skip-null          is rw;   #=  VMDK | RAW | VHD
  has Str    $.s3Bucket           is xml-element    is xml-skip-null          is rw;
  has Str    $.s3Key              is xml-element    is xml-skip-null          is rw;
}
