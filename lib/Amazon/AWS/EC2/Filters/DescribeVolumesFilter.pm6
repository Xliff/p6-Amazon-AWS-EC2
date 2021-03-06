use v6.d;

use XML::Class;

use Amazon::AWS::Roles::Base;
use Amazon::AWS::Roles::Eqv;

class Amazon::AWS::EC2::Filters::DescribeVolumesFilters::Attachment
  does XML::Class[xml-element => 'attachment']
{
  also does Amazon::AWS::Roles::Base;
  also does Amazon::AWS::Roles::Eqv;
  
  has Str        $.attach-time             is xml-element    is rw;
  has Bool       $.delete-on-termination   is xml-element    is rw;
  has Str        $.device                  is xml-element    is rw;
  has Str        $.status                  is xml-element    is rw;  #= sttaching | attached | detaching
}

constant Attachment := Amazon::AWS::EC2::Filters::DescribeVolumesFilters::Attachment;

class Amazon::AWS::EC2::Filters::DescribeVolumesFilter is export 
  does XML::Class
{
  also does Amazon::AWS::Roles::Base;
  also does Amazon::AWS::Roles::Eqv;
  
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
