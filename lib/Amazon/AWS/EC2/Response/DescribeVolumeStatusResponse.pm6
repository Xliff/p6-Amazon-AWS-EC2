use v6.d;

use Amazon::AWS::Roles::Response;

use XML::Class;

use Amazon::AWS::EC2::Types::VolumeStatusItem;

class Amazon::AWS::EC2::Response::DescribeVolumeStatusResponse is export
  does XML::Class[xml-element => 'DescribeVolumeStatusResponse']
{
  also does Amazon::AWS::Roles::Response;

  has Str                 $.nextToken      is xml-element                                       is rw;
  has VolumeStatusItem    @.volume-status                  is xml-container('volumeStatusSet')  is rw;
}
