use v6.d;

use XML::Class;

use Amazon::AWS::EC2::Types::Base;

class Amazon::AWS::EC2::Types::UserIdGroupPair is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;
  
  # ... REALLY redundant.
  
  # Request
  has Str $.Description            is xml-element is rw;  #= Up to 255 characters in length. Allowed characters are a-z, A-Z, 0-9, spaces, and ._-:/()#,@[]+=;{}!$*
  has Str $.GroupId                is xml-element is rw;
  has Str $.GroupName              is xml-element is rw;
  has Str $.PeeringStatus          is xml-element is rw;
  has Str $.UserId                 is xml-element is rw;
  has Str $.VpcId                  is xml-element is rw;
  has Str $.VpcPeeringConnectionId is xml-element is rw;  
  
  # Response
  has Str $.description            is xml-element is rw;
  has Str $.groupId                is xml-element is rw;
  has Str $.groupName              is xml-element is rw;
  has Str $.peeringStatus          is xml-element is rw;
  has Str $.userId                 is xml-element is rw;
  has Str $.vpcId                  is xml-element is rw;
  has Str $.vpcPeeringConnectionId is xml-element is rw;
}
