use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;

use Amazon::AWS::EC2::Types::GpuDeviceMemoryInfo;

class Amazon::AWS::EC2::Types::GpuDeviceInfo is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Int                    $.count           is xml-element                is xml-skip-null          is rw;
  has Str                    $.manufacturer    is xml-element                is xml-skip-null          is rw;
  has GpuDeviceMemoryInfo    $.memoryInfo      is xml-element(:over-ride)    is xml-skip-null          is rw;
  has Str                    $.name            is xml-element                is xml-skip-null          is rw; 
}
