use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;



class Amazon::AWS::EC2::Types::InstanceState is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Int    $.code    is xml-element    is xml-skip-null          is rw; 
  has Str    $.name    is xml-element    is xml-skip-null          is rw;   #=  pending | running | shutting-down | terminated | stopping | stopped
}