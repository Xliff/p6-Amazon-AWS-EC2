use v6.d;

use Amazon::AWS::Roles::Response;

use XML::Class;

use Amazon::AWS::EC2::Types::PrincipalIdFormat;

class Amazon::AWS::EC2::Response::DescribePrincipalIdFormatResponse is export
  does XML::Class[xml-element => 'DescribePrincipalIdFormatResponse']
{
  also does Amazon::AWS::Roles::Response;

  has Str                  $.nextToken     is xml-element                                          is rw; 
  has PrincipalIdFormat    @.principals                      is xml-container('principalSet')      is rw; 
}
