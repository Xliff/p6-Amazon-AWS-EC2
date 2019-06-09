use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;



class Amazon::AWS::EC2::Types::PrivateIpAddressSpecification is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Bool    $.Primary             is xml-element          is rw; 
  has Bool    $.primary             is xml-element          is rw; 
  has Str     $.PrivateIpAddress    is xml-element          is rw; 
  has Str     $.privateIpAddress    is xml-element          is rw; 
}