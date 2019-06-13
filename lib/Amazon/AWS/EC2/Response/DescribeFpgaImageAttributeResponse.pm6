use v6.d;

use Amazon::AWS::Roles::Response;

use XML::Class;

use Amazon::AWS::EC2::Types::FpgaImageAttribute;

class Amazon::AWS::EC2::Response::DescribeFpgaImageAttributeResponse is export
  does XML::Class[xml-element => 'DescribeFpgaImageAttributeResponse']
{
  also does Amazon::AWS::Roles::Response;

  has FpgaImageAttribute    $.fpgaImageAttribute    is xml-element          is rw; 
}