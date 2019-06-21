use v6.d;

use Amazon::AWS::Roles::Base;
use Amazon::AWS::Roles::Eqv;

use XML::Class;

class Amazon::AWS::EC2::Filters::DescribeAvailabilityZonesFilter is export
  does XML::Class[xml-element => 'item']
{
  also does Amazon::AWS::Roles::Base;
  also does Amazon::AWS::Roles::Eqv;
  
  has Str $.message        is xml-element is xml-skip-null is rw;
  has Str $.region-name    is xml-element is xml-skip-null is rw;
  has Str $.state          is xml-element is xml-skip-null is rw;  #= available | information | impaired | unavailable
  has Str $.zone-id        is xml-element is xml-skip-null is rw;
  has Str $.zone-name      is xml-element is xml-skip-null is rw;
} 
