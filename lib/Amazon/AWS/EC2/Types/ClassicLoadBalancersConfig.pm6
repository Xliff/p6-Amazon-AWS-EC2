use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;

use Amazon::AWS::EC2::Types::ClassicLoadBalancer;

class Amazon::AWS::EC2::Types::ClassicLoadBalancersConfig is export
  does XML::Class
{
  also is Amazon::AWS::EC2::Types::Base;

  has ClassicLoadBalancer    @.ClassicLoadBalancers    is xml-skip-null    is xml-container('ClassicLoadBalancerSet')      is rw;
  has ClassicLoadBalancer    @.classicLoadBalancers    is xml-skip-null    is xml-container('classicLoadBalancerSet')      is rw;
}
