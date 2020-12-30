use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;

use Amazon::AWS::EC2::Types::DiskInfo;

class Amazon::AWS::EC2::Types::InstanceStorageInfo is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has DiskInfo  @.disks            is xml-element('item', :over-ride)   is xml-skip-null    is xml-container('diskSet')    is rw;
  has Str       $.nvmeSupport      is xml-element                       is xml-skip-null                                   is rw;   #=  unsupported | supported | required
  has Int       $.totalSizeInGB    is xml-element                       is xml-skip-null                                   is rw;
}
