use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;



class Amazon::AWS::EC2::Types::UserBucket is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Str    $.S3Bucket    is xml-element          is rw; 
  has Str    $.S3Key       is xml-element          is rw; 
}