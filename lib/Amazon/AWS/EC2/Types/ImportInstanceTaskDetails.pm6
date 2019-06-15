use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;

use Amazon::AWS::EC2::Types::ImportInstanceVolumeDetailItem;

class Amazon::AWS::EC2::Types::ImportInstanceTaskDetails is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Str                               $.description    is xml-element    is xml-skip-null                                     is rw; 
  has Str                               $.instanceId     is xml-element    is xml-skip-null                                     is rw; 
  has Str                               $.platform       is xml-element    is xml-skip-null                                     is rw;   #=  Windows
  has ImportInstanceVolumeDetailItem    @.volumes        is xml-element    is xml-skip-null    is xml-container('volumes')      is rw; 
}