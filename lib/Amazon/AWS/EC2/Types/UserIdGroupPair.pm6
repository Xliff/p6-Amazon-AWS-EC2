use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;



class Amazon::AWS::EC2::Types::UserIdGroupPair is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Str    $.Description               is xml-element    is xml-skip-null          is rw; 
  has Str    $.description               is xml-element    is xml-skip-null          is rw; 
  has Str    $.GroupId                   is xml-element    is xml-skip-null          is rw; 
  has Str    $.groupId                   is xml-element    is xml-skip-null          is rw; 
  has Str    $.GroupName                 is xml-element    is xml-skip-null          is rw; 
  has Str    $.groupName                 is xml-element    is xml-skip-null          is rw; 
  has Str    $.PeeringStatus             is xml-element    is xml-skip-null          is rw; 
  has Str    $.peeringStatus             is xml-element    is xml-skip-null          is rw; 
  has Str    $.UserId                    is xml-element    is xml-skip-null          is rw; 
  has Str    $.userId                    is xml-element    is xml-skip-null          is rw; 
  has Str    $.VpcId                     is xml-element    is xml-skip-null          is rw; 
  has Str    $.vpcId                     is xml-element    is xml-skip-null          is rw; 
  has Str    $.VpcPeeringConnectionId    is xml-element    is xml-skip-null          is rw; 
  has Str    $.vpcPeeringConnectionId    is xml-element    is xml-skip-null          is rw; 
}