use v6.d;

use Amazon::AWS::Roles::Response;

use XML::Class;



class Amazon::AWS::EC2::Response::CreateImageResponse is export
  does XML::Class[xml-element => 'CreateImageResponse']
{
  also does Amazon::AWS::Roles::Response;

  has Str    $.imageId    is xml-element          is rw; 
}