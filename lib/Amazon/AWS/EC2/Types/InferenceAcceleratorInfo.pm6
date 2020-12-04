use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;

use Amazon::AWS::EC2::Types::InferenceDeviceInfo;

class Amazon::AWS::EC2::Types::InferenceAcceleratorInfo is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has InferenceDeviceInfo    @.accelerators    is xml-element('item', :over-ride)    is xml-skip-null    is xml-container('accelerators')  is rw;
}
