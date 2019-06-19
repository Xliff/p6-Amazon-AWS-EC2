use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;



class Amazon::AWS::EC2::Types::PlacementGroup is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Str    $.groupName         is xml-element    is xml-skip-null          is rw; 
  has Int    $.partitionCount    is xml-element    is xml-skip-null          is rw; 
  has Str    $.state             is xml-element    is xml-skip-null          is rw;   #=  pending | available | deleting | deleted
  has Str    $.strategy          is xml-element    is xml-skip-null          is rw;   #=  cluster | spread | partition
}