use v6.d;

use Amazon::AWS::Roles::Response;

use XML::Class;



class Amazon::AWS::EC2::Response::GetPasswordDataResponse is export
  does XML::Class[xml-element => 'item']
{
  also does Amazon::AWS::Roles::Response;

  has Str    $.instanceId      is xml-element          is rw; 
  has Str    $.passwordData    is xml-element          is rw; 
  has Str    $.timestamp       is xml-element          is rw; 
}