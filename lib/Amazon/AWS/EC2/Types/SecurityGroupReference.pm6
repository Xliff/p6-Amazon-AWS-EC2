use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;



class Amazon::AWS::EC2::Types::SecurityGroupReference is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Str    $.groupId                   is xml-element    is xml-skip-null          is rw; 
  has Str    $.referencingVpcId          is xml-element    is xml-skip-null          is rw; 
  has Str    $.vpcPeeringConnectionId    is xml-element    is xml-skip-null          is rw; 
}