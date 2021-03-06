use v6.d;

use Amazon::AWS::Roles::Response;

use XML::Class;



class Amazon::AWS::EC2::Response::ImportKeyPairResponse is export
  does XML::Class[xml-element => 'ImportKeyPairResponse']
{
  also does Amazon::AWS::Roles::Response;

  has Str    $.keyFingerprint    is xml-element          is rw; 
  has Str    $.keyName           is xml-element          is rw; 
}