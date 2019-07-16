use v6.d;

use XML::Class;

use Amazon::AWS::Roles::Base;
use Amazon::AWS::Roles::Eqv;

use Amazon::AWS::Utils;

my %attributes;

class Amazon::AWS::EC2::Filters::DescribeVpcEndpointConnectionsFilter is export
  does XML::Class
{ 
  also does Amazon::AWS::Roles::Base;
  also does Amazon::AWS::Roles::Eqv;

  has Str $.service-id          is xml-skip-null is xml-element is rw;
  has Str $.vpc-endpoint-owner  is xml-skip-null is xml-element is rw;
  has Str $.vpc-endpoint-id     is xml-skip-null is xml-element is rw;
  has Str $.vpc-endpoint-state  is xml-skip-null is xml-element is rw;  #=  pendingAcceptance | pending | available | deleting | deleted | rejected | failed
  has Str $.tag-key             is xml-skip-null is xml-element is rw;
  
  method getValidStates {
    %attributes<vpc-endpoint-state|ValidValues>.Array;
  }
}

BEGIN {
  %attributes = getAttributeData(
    Amazon::AWS::EC2::Filters::DescribeVpcEndpointConnectionsFilter
  );
}
