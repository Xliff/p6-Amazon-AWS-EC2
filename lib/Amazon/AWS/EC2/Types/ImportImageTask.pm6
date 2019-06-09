use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;

use Amazon::AWS::EC2::Types::SnapshotDetail;

class Amazon::AWS::EC2::Types::ImportImageTask is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Str               $.architecture       is xml-element                                               is rw; 
  has Str               $.description        is xml-element                                               is rw; 
  has Bool              $.encrypted          is xml-element                                               is rw; 
  has Str               $.hypervisor         is xml-element                                               is rw; 
  has Str               $.imageId            is xml-element                                               is rw; 
  has Str               $.importTaskId       is xml-element                                               is rw; 
  has Str               $.kmsKeyId           is xml-element                                               is rw; 
  has Str               $.licenseType        is xml-element                                               is rw; 
  has Str               $.platform           is xml-element                                               is rw; 
  has Str               $.progress           is xml-element                                               is rw; 
  has SnapshotDetail    @.snapshotDetails    is xml-element    is xml-container('snapshotDetailSet')      is rw; 
  has Str               $.status             is xml-element                                               is rw; 
  has Str               $.statusMessage      is xml-element                                               is rw; 
}