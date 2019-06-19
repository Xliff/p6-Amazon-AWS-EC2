use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;



class Amazon::AWS::EC2::Types::PrivateIpAddressSpecification is export
  does XML::Class
{
  also is Amazon::AWS::EC2::Types::Base;

  has Bool    $.Primary             is xml-element    is xml-skip-null          is rw;
  has Bool    $.primary             is xml-element    is xml-skip-null          is rw;
  has Str     $.PrivateIpAddress    is xml-element    is xml-skip-null          is rw;
  has Str     $.privateIpAddress    is xml-element    is xml-skip-null          is rw;
}
