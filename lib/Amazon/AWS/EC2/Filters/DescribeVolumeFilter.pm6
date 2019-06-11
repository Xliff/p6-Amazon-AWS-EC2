use v6.d;

use XML::Class;

use Amazon::AWS::Roles::Base;

class Amazon::AWS::EC2::Filters::DescribeVolumeFilters::Attachment
  does XML::Class[xml-element => 'attachment']
{
  also does Amazon::AWS::Roles::Base;
  
  has Str        $.attach-time             is xml-element    is rw;
  has Bool       $.delete-on-termination   is xml-element    is rw;
  has Str        $.device                  is xml-element    is rw;
  has Str        $.status                  is xml-element    is rw;  #= sttaching | attached | detaching
}

constant Attachment := Amazon::AWS::EC2::Filters::DescribeVolumeFilters::Attachment;

class Amazon::AWS::EC2::Filters::DescribeVolumeFilter is export 
  does XML::Class[xml-element => 'item']
{
  also does Amazon::AWS::Roles::Base;
  
  has Attachment $.attachment                                is rw;
  has Str        $.availability-zone       is xml-element    is rw;
  has Str        $.create-time             is xml-element    is rw;
  has Bool       $.encrypted               is xml-element    is rw;
  has Int        $.size                    is xml-element    is rw;
  has Str        $.snapshot-id             is xml-element    is rw;
  has Str        $.status                  is xml-element    is rw;  #= creating | available | in-use | deleting | deleted | error
  has Str        $.tag-key                 is xml-element    is rw;
  has Str        $.volume-id               is xml-element    is rw;
  has Str        $.volume-type             is xml-element    is rw; #= gp2 | io1 | st1 | sc1 | standard
}
