use v6.d;

use Amazon::AWS::Roles::Response;

use XML::Class;



class Amazon::AWS::EC2::Response::CopyImageResponse is export
  does XML::Class[xml-element => 'CopyImageResponse']
{
  also does Amazon::AWS::Roles::Response;

  has Str    $.imageId    is xml-element          is rw; 
}