use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;



class Amazon::AWS::EC2::Types::ClientData is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Str    $.Comment        is xml-element    is xml-skip-null          is rw; 
  has Str    $.UploadEnd      is xml-element    is xml-skip-null          is rw; 
  has Num    $.UploadSize     is xml-element    is xml-skip-null          is rw; 
  has Str    $.UploadStart    is xml-element    is xml-skip-null          is rw; 
}