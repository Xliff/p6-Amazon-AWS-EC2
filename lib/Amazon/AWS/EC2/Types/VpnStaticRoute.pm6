use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;



class Amazon::AWS::EC2::Types::VpnStaticRoute is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Str    $.destinationCidrBlock    is xml-element    is xml-skip-null          is rw; 
  has Str    $.source                  is xml-element    is xml-skip-null          is rw;   #=  Static
  has Str    $.state                   is xml-element    is xml-skip-null          is rw;   #=  pending | available | deleting | deleted
}