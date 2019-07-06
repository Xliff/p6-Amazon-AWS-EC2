use v6.d;

use XML::Class;

use Amazon::AWS::Roles::Base;
use Amazon::AWS::Roles::Eqv;

use Amazon::AWS::Utils;

my %attributes;

class Amazon::AWS::EC2::Filters::DescribePlacementGroupsFilter is export
  does XML::Class[xml-element => 'item']
{
  also does Amazon::AWS::Roles::Base;
  also does Amazon::AWS::Roles::Eqv;

  has Str $.group-name is xml-element is rw;  
  has Str $.state      is xml-element is rw;  #=  pending | available | deleting | deleted
  has Str $.strategy   is xml-element is rw;  #=  cluster | spread | partition
  
  method getValidStates {
    %attributes<state|ValidValues>.Array
  }
  
  method getValidStrategies {
    %attributes<strategy|ValidValues>.Array
  }
}

BEGIN {
  %attributes = getAttributeData(
    Amazon::AWS::EC2::Filters::DescribePlacementGroupsFilter
  );
}
