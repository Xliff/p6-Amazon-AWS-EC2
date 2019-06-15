use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;



class Amazon::AWS::EC2::Types::VolumeStatusDetails is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Str    $.name      is xml-element    is xml-skip-null          is rw;   #=  io-enabled | io-performance
  has Str    $.status    is xml-element    is xml-skip-null          is rw; 
}