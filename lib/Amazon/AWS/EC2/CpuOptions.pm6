use v6.d;

use Amazon::AWS::EC2::Base;

use XML::Class;

class Amazon::AWS::EC2::CpuOptions is export
  does XML::Class[xml-element => 'cpuOptions']
{
  also is Amazon::AWS::EC2::Base;

  has Int $.coreCount      is xml-element is rw;
  has Int $.threadsPerCore is xml-element is rw;
}
