use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;

use Amazon::AWS::EC2::Types::ClassicLoadBalancersConfig;
use Amazon::AWS::EC2::Types::TargetGroupsConfig;

class Amazon::AWS::EC2::Types::LoadBalancersConfig is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has ClassicLoadBalancersConfig    $.ClassicLoadBalancersConfig    is xml-element(:over-ride)    is xml-skip-null          is rw; 
  has ClassicLoadBalancersConfig    $.classicLoadBalancersConfig    is xml-element(:over-ride)    is xml-skip-null          is rw; 
  has TargetGroupsConfig            $.TargetGroupsConfig            is xml-element(:over-ride)    is xml-skip-null          is rw; 
  has TargetGroupsConfig            $.targetGroupsConfig            is xml-element(:over-ride)    is xml-skip-null          is rw; 
}
