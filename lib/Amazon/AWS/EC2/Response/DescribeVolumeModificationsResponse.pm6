use v6.d;

use Amazon::AWS::Roles::Response;

use XML::Class;

use Amazon::AWS::EC2::Types::VolumeModification;

class Amazon::AWS::EC2::Response::DescribeVolumeModificationsResponse is export
  does XML::Class[xml-element => 'DescribeVolumeModificationsResponse']
{
  also does Amazon::AWS::Roles::Response;

  has Str                 $.nextToken            is xml-element                                                     is xml-skip-null is rw;
  has VolumeModification  @.volumeModifications  is xml-element('item', :over-ride)  is xml-container('volumeSet')  is xml-skip-null is rw;
}
