use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;

use Amazon::AWS::EC2::Types::ClientVpnAuthorizationRuleStatus;

class Amazon::AWS::EC2::Types::AuthorizationRule is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Bool                                $.accessAll              is xml-element                is xml-skip-null          is rw; 
  has Str                                 $.clientVpnEndpointId    is xml-element                is xml-skip-null          is rw;
  has Str                                 $.description            is xml-element                is xml-skip-null          is rw;
  has Str                                 $.destinationCidr        is xml-element                is xml-skip-null          is rw;
  has Str                                 $.groupId                is xml-element                is xml-skip-null          is rw;
  has ClientVpnAuthorizationRuleStatus    $.status                 is xml-element(:over-ride)    is xml-skip-null          is rw;
}
