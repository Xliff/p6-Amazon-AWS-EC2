use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;

use Amazon::AWS::EC2::Types::CertificateAuthenticationRequest;
use Amazon::AWS::EC2::Types::DirectoryServiceAuthenticationRequest;

class Amazon::AWS::EC2::Types::ClientVpnAuthenticationRequest is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has DirectoryServiceAuthenticationRequest    $.ActiveDirectory         is xml-element    is xml-skip-null          is rw; 
  has CertificateAuthenticationRequest         $.MutualAuthentication    is xml-element    is xml-skip-null          is rw; 
  has Str                                      $.Type                    is xml-element    is xml-skip-null          is rw;   #=  certificate-authentication | directory-service-authentication
}