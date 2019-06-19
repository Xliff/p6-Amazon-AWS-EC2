use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;

use Amazon::AWS::EC2::validInstanceTypes;

# Needs Attribute check Code

class Amazon::AWS::EC2::Types::ElasticInferenceAccelerator is export
  does XML::Class
{
  also is Amazon::AWS::EC2::Types::Base;

  has Str $.type is xml-element is xml-skip-null is rw;  #= eia1.small eia1.medium eia1.large
}
