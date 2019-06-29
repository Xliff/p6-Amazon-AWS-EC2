use v6.d;

use Amazon::AWS::Roles::Response;

use Amazon::AWS::EC2::Types::AttributeBooleanValue;
use Amazon::AWS::EC2::Types::ProductCode;

use XML::Class;

class Amazon::AWS::EC2::Response::DescribeVolumesAttributeResponse is export
  does XML::Class[xml-element => 'DescribeVolumesAttributeResponse']
{
  also does Amazon::AWS::Roles::Response;

  has AttributeBooleanValue $.autoEnableIO is xml-element(        :over-ride)                                        is xml-skip-null is rw;                                                            is xml-skip-null is rw;
  has ProductCode           @.productCodes is xml-element('item', :over-ride)  is xml-container('productCodeSet')    is xml-skip-null is rw;
  has Str                   $.volumeId     is xml-element                                                            is xml-skip-null is rw;
}
