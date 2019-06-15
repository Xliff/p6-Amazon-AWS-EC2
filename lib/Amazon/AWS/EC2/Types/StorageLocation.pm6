use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;



class Amazon::AWS::EC2::Types::StorageLocation is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Str    $.Bucket    is xml-element    is xml-skip-null          is rw; 
  has Str    $.Key       is xml-element    is xml-skip-null          is rw; 
}