use v6.d;

use Amazon::AWS::Roles::Response;

use XML::Class;



class Amazon::AWS::EC2::Response::CreateFpgaImageResponse is export
  does XML::Class[xml-element => 'item']
{
  also does Amazon::AWS::Roles::Response;

  has Str    $.fpgaImageGlobalId    is xml-element          is rw; 
  has Str    $.fpgaImageId          is xml-element          is rw; 
}