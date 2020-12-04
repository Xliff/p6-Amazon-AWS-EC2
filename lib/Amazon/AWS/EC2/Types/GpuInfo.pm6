use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;

use Amazon::AWS::EC2::Types::GpuDeviceInfo;

class Amazon::AWS::EC2::Types::GpuInfo is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has GpuDeviceInfo  @.gpus                   is xml-element('item', :over-ride)    is xml-skip-null    is xml-container('gpuSet')      is rw;
  has Int            $.totalGpuMemoryInMiB    is xml-element                        is xml-skip-null                                    is rw;
}
