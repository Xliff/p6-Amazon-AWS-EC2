use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;

use Amazon::AWS::EC2::Types::TargetGroup;

class Amazon::AWS::EC2::Types::TargetGroupsConfig is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has TargetGroup    @.TargetGroups    is xml-element    is xml-skip-null    is xml-container('TargetGroups')      is rw; 
  has TargetGroup    @.targetGroups    is xml-element    is xml-skip-null    is xml-container('targetGroups')      is rw; 
}