use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;



class Amazon::AWS::EC2::Types::ExportToS3TaskSpecification is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Str    $.ContainerFormat    is xml-element          is rw;   #=  ova
  has Str    $.DiskImageFormat    is xml-element          is rw;   #=  VMDK | RAW | VHD
  has Str    $.S3Bucket           is xml-element          is rw; 
  has Str    $.S3Prefix           is xml-element          is rw; 
}