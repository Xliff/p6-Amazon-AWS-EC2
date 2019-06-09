use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;



class Amazon::AWS::EC2::Types::S3Storage is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Str    $.AWSAccessKeyId           is xml-element          is rw;
  has Str    $.Bucket                   is xml-element          is rw;
  has Str    $.bucket                   is xml-element          is rw;
  has Str    $.Prefix                   is xml-element          is rw;
  has Str    $.prefix                   is xml-element          is rw;
  has Str    $.UploadPolicy             is xml-element          is rw;
  has Str    $.uploadPolicy             is xml-element          is rw;
  has Str    $.UploadPolicySignature    is xml-element          is rw;
  has Str    $.uploadPolicySignature    is xml-element          is rw;
}
