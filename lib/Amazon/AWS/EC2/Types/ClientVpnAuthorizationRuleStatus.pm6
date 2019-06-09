use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;



class Amazon::AWS::EC2::Types::ClientVpnAuthorizationRuleStatus is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Str    $.code       is xml-element          is rw;   #=  authorizing | active | failed | revoking
  has Str    $.message    is xml-element          is rw; 
}