use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;



class Amazon::AWS::EC2::Types::CidrBlock is export
  does XML::Class
{
  also is Amazon::AWS::EC2::Types::Base;

  has Str    $.cidrBlock    is xml-element    is xml-skip-null          is rw;
}
