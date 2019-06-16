use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;



class Amazon::AWS::EC2::Types::ProvisionedBandwidth is export
  does XML::Class
{
  also is Amazon::AWS::EC2::Types::Base;

  has Str    $.provisioned      is xml-element    is xml-skip-null          is rw;
  has Str    $.provisionTime    is xml-element    is xml-skip-null          is rw;
  has Str    $.requested        is xml-element    is xml-skip-null          is rw;
  has Str    $.requestTime      is xml-element    is xml-skip-null          is rw;
  has Str    $.status           is xml-element    is xml-skip-null          is rw;
}
