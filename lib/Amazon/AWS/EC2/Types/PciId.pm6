use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;



class Amazon::AWS::EC2::Types::PciId is export
  does XML::Class
{
  also is Amazon::AWS::EC2::Types::Base;

  has Str    $.DeviceId             is xml-element    is xml-skip-null          is rw;
  has Str    $.SubsystemId          is xml-element    is xml-skip-null          is rw;
  has Str    $.SubsystemVendorId    is xml-element    is xml-skip-null          is rw;
  has Str    $.VendorId             is xml-element    is xml-skip-null          is rw;
}
