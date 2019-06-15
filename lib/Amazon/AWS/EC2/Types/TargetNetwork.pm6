use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;

use Amazon::AWS::EC2::Types::AssociationStatus;

class Amazon::AWS::EC2::Types::TargetNetwork is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Str                  $.associationId          is xml-element    is xml-skip-null                                            is rw; 
  has Str                  $.clientVpnEndpointId    is xml-element    is xml-skip-null                                            is rw; 
  has Str                  @.securityGroups         is xml-element    is xml-skip-null    is xml-container('securityGroups')      is rw; 
  has AssociationStatus    $.status                 is xml-element    is xml-skip-null                                            is rw; 
  has Str                  $.targetNetworkId        is xml-element    is xml-skip-null                                            is rw; 
  has Str                  $.vpcId                  is xml-element    is xml-skip-null                                            is rw; 
}