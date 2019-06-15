use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;

use Amazon::AWS::EC2::Types::CertificateAuthentication;
use Amazon::AWS::EC2::Types::DirectoryServiceAuthentication;

class Amazon::AWS::EC2::Types::ClientVpnAuthentication is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has DirectoryServiceAuthentication    $.activeDirectory         is xml-element(:over-ride)    is xml-skip-null          is rw;
  has CertificateAuthentication         $.mutualAuthentication    is xml-element(:over-ride)    is xml-skip-null          is rw;
  has Str                               $.type                    is xml-element                is xml-skip-null          is rw;   #=  certificate-authentication | directory-service-authentication
}
