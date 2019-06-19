use v6.d;

use Amazon::AWS::Roles::Response;

use XML::Class;

use Amazon::AWS::EC2::Types::FpgaImageAttribute;

class Amazon::AWS::EC2::Response::ModifyFpgaImageAttributeResponse is export
  does XML::Class[xml-element => 'ModifyFpgaImageAttributeResponse']
{
  also does Amazon::AWS::Roles::Response;

  has FpgaImageAttribute    $.fpgaImageAttribute    is xml-element          is rw; 
}