use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;



class Amazon::AWS::EC2::Types::PublicIpv4PoolRange is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Int    $.addressCount             is xml-element    is xml-skip-null          is rw; 
  has Int    $.availableAddressCount    is xml-element    is xml-skip-null          is rw; 
  has Str    $.firstAddress             is xml-element    is xml-skip-null          is rw; 
  has Str    $.lastAddress              is xml-element    is xml-skip-null          is rw; 
}