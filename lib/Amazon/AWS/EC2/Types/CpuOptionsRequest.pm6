use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;



class Amazon::AWS::EC2::Types::CpuOptionsRequest is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Int    $.CoreCount         is xml-element    is xml-skip-null          is rw; 
  has Int    $.ThreadsPerCore    is xml-element    is xml-skip-null          is rw; 
}