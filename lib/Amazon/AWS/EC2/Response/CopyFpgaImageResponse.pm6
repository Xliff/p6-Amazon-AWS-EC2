use v6.d;

use Amazon::AWS::Roles::Response;

use XML::Class;



class Amazon::AWS::EC2::Response::CopyFpgaImageResponse is export
  does XML::Class[xml-element => 'CopyFpgaImageResponse']
{
  also does Amazon::AWS::Roles::Response;

  has Str    $.fpgaImageId    is xml-element          is rw; 
}