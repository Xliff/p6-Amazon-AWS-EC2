use v6.d;

use Amazon::AWS::Roles::Base;
use Amazon::AWS::Roles::Eqv;

use XML::Class;

class Amazon::AWS::EC2::Filters::DescribeFlowLogsFilter is export
  does XML::Class[xml-element => 'item']
{
  also does Amazon::AWS::Roles::Base;
  also does Amazon::AWS::Roles::Eqv;
  
  has Str $.deliver-log-status        is xml-element is xml-skip-null is rw;  #= SUCCESS | FAILED
  has Str $.log-destination-type      is xml-element is xml-skip-null is rw;
  has Str $.flow-log-id               is xml-element is xml-skip-null is rw; 
  has Str $.log-group-name            is xml-element is xml-skip-null is rw;
  has Str $.resource-id               is xml-element is xml-skip-null is rw;
  has Str $.traffic-type              is xml-element is xml-skip-null is rw;  #= ACCEPT | REJECT | ALL
} 
