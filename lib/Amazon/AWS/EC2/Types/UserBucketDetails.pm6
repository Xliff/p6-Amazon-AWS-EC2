use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;



class Amazon::AWS::EC2::Types::UserBucketDetails is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Str    $.s3Bucket    is xml-element          is rw; 
  has Str    $.s3Key       is xml-element          is rw; 
}