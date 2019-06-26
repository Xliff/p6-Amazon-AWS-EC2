use v6.d;

use XML::Class;

use Amazon::AWS::Roles::Base;
use Amazon::AWS::Roles::Eqv;

class Amazon::AWS::EC2::Filters::DescribeElasticGpusFilter is export
  does XML::Class[xml-element => 'item']
{
  also does Amazon::AWS::Roles::Base;
  also does Amazon::AWS::Roles::Eqv;

  has Str $.availability-zone  is xml-element is rw;
  has Str $.elastic-gpu-health is xml-element is rw; #= OK | IMPAIRED
  has Str $.elastic-gpu-state  is xml-element is rw; #= ATTACHED
  has Str $.elastic-gpu-type   is xml-element is rw; 
  has Str $.instance-id        is xml-element is rw;
}
