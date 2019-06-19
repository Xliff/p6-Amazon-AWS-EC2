use v6.d;

use Amazon::AWS::Roles::Response;

use XML::Class;



class Amazon::AWS::EC2::Response::AllocateAddressResponse is export
  does XML::Class[xml-element => 'AllocateAddressResponse']
{
  also does Amazon::AWS::Roles::Response;

  has Str    $.allocationId      is xml-element          is rw; 
  has Str    $.domain            is xml-element          is rw;   #=  vpc | standard
  has Str    $.publicIp          is xml-element          is rw; 
  has Str    $.publicIpv4Pool    is xml-element          is rw; 
}