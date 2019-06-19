use v6.d;

use Amazon::AWS::Roles::Response;

use XML::Class;

use Amazon::AWS::EC2::Types::CreateVolumePermission;
use Amazon::AWS::EC2::Types::ProductCode;

class Amazon::AWS::EC2::Response::DescribeSnapshotAttributeResponse is export
  does XML::Class[xml-element => 'DescribeSnapshotAttributeResponse']
{
  also does Amazon::AWS::Roles::Response;

  has CreateVolumePermission @.createVolumePermission  is xml-container('createVolumePermission')                   is xml-skip-null is rw;
  has ProductCode            @.productCodes            is xml-container('productCode')                              is xml-skip-null is rw;
  has Str                    $.snapshotId                                                         is xml-element    is xml-skip-null is rw; 
}
