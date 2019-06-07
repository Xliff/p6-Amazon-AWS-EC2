use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;

class Amazon::AWS::EC2::Types::CpuOptions is export
  does XML::Class[xml-element => 'cpuOptions']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Int $.coreCount      is xml-element is rw;
  has Int $.threadsPerCore is xml-element is rw;
}
