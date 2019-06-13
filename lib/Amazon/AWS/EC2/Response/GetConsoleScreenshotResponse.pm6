use v6.d;

use Amazon::AWS::Roles::Response;

use XML::Class;



class Amazon::AWS::EC2::Response::GetConsoleScreenshotResponse is export
  does XML::Class[xml-element => 'GetConsoleScreenshotResponse']
{
  also does Amazon::AWS::Roles::Response;

  has Str    $.imageData     is xml-element          is rw; 
  has Str    $.instanceId    is xml-element          is rw; 
}