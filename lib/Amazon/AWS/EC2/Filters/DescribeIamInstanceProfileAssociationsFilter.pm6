use v6.d;

use XML::Class;

use Amazon::AWS::Roles::Eqv;
use Amazon::AWS::Utils;

my %attributes;

class Amazon::AWS::EC2::Filters::DescribeIamInstanceProfileAssociationsFilter 
  is export 
  does XML::Class[xml-element => 'item']
{
  also does Amazon::AWS::Roles::Eqv;
  
  has Str $.instance-id is xml-element is xml-skip-null is rw;
  has Str $.state       is xml-element is xml-skip-null is rw;  #=  associating | associated | disassociating | disassociated
  
  method getValidStates {
    %attributes<States|ValidValues>.Array
  }
}

# For direct access to any Attribute metadata.
BEGIN {
  %attributes = getAttributeData(
    Amazon::AWS::EC2::Filters::DescribeIamInstanceProfileAssociationsFilter
  )
}
