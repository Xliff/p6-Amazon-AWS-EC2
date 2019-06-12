use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;

use Amazon::AWS::EC2::validInstanceTypes;

class Amazon::AWS::EC2::Types::ElasticInferenceAccelerator is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Str $.type is xml-element is rw;

  method setType($newType) {
    my @valid-types = <eia1.small eia1.medium eia1.large>;

    die "Invalid type '{$newType}' given. Valid types are:{
         @valid-instance-types.join(', ') }"
      unless checkInstanceType($newType);
  }

}
