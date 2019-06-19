use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;



class Amazon::AWS::EC2::Types::AllowedPrincipal is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Str    $.principal        is xml-element    is xml-skip-null          is rw; 
  has Str    $.principalType    is xml-element    is xml-skip-null          is rw;   #=  All | Service | OrganizationUnit | Account | User | Role
}