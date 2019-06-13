use v6.d;

use Amazon::AWS::Roles::Response;

use XML::Class;



class Amazon::AWS::EC2::Response::ResetFpgaImageAttributeResponse is export
  does XML::Class[xml-element => 'ResetFpgaImageAttributeResponse']
{
  also does Amazon::AWS::Roles::Response;

  has Bool    $.return    is xml-element          is rw; 
}