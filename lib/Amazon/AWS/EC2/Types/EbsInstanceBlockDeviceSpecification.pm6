use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;



class Amazon::AWS::EC2::Types::EbsInstanceBlockDeviceSpecification is export
  does XML::Class
{
  also is Amazon::AWS::EC2::Types::Base;

  has Bool    $.DeleteOnTermination    is xml-element    is xml-skip-null          is rw;
  has Str     $.VolumeId               is xml-element    is xml-skip-null          is rw;
}
