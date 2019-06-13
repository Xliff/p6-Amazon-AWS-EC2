use v6.d;

use Amazon::AWS::Roles::Response;

use XML::Class;

use Amazon::AWS::EC2::Types::ByoipCidr;

class Amazon::AWS::EC2::Response::DeprovisionByoipCidrResponse is export
  does XML::Class[xml-element => 'DeprovisionByoipCidrResponse']
{
  also does Amazon::AWS::Roles::Response;

  has ByoipCidr    $.byoipCidr    is xml-element          is rw; 
}