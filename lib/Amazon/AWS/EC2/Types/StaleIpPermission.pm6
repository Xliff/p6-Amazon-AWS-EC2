use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;

use Amazon::AWS::EC2::Types::UserIdGroupPair;

class Amazon::AWS::EC2::Types::StaleIpPermission is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Int                $.fromPort         is xml-element    is xml-skip-null                                           is rw; 
  has UserIdGroupPair    @.groups           is xml-element    is xml-skip-null    is xml-container('groups')             is rw; 
  has Str                $.ipProtocol       is xml-element    is xml-skip-null                                           is rw; 
  has Str                @.ipRanges         is xml-element    is xml-skip-null    is xml-container('ipRanges')           is rw; 
  has Str                @.prefixListIds    is xml-element    is xml-skip-null    is xml-container('prefixListIds')      is rw; 
  has Int                $.toPort           is xml-element    is xml-skip-null                                           is rw; 
}