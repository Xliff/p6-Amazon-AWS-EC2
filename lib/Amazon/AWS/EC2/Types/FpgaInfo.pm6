use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;

use Amazon::AWS::EC2::Types::FpgaDeviceInfo;

class Amazon::AWS::EC2::Types::FpgaInfo is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has FpgaDeviceInfo  @.fpgas                   is xml-element('item', :over-ride)     is xml-skip-null    is xml-container('fpgaSet')    is rw;
  has Int             $.totalFpgaMemoryInMiB    is xml-element                         is xml-skip-null                                   is rw;
}
