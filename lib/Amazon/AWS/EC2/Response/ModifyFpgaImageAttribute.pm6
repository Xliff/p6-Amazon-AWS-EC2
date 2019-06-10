use v6.d;

use Amazon::AWS::Roles::Response;

use XML::Class;

use Amazon::AWS::EC2::Types::FpgaImageAttribute;

class Amazon::AWS::EC2::Types::Response::ModifyFpgaImageAttributeResponse is export
  does XML::Class[xml-element => 'item']
{
  also does Amazon::AWS::Roles::Response;

  has FpgaImageAttribute    $.fpgaImageAttribute    is xml-element          is rw; 
}