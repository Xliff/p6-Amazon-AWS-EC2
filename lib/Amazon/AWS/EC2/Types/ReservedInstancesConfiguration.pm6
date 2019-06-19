use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;



class Amazon::AWS::EC2::Types::ReservedInstancesConfiguration is export
  does XML::Class
{
  also is Amazon::AWS::EC2::Types::Base;

  has Str    $.AvailabilityZone    is xml-element    is xml-skip-null          is rw;
  has Str    $.availabilityZone    is xml-element    is xml-skip-null          is rw;
  has Int    $.InstanceCount       is xml-element    is xml-skip-null          is rw;
  has Int    $.instanceCount       is xml-element    is xml-skip-null          is rw;
  has Str    $.InstanceType        is xml-element    is xml-skip-null          is rw;   #=  sub:Amazon::AWS::EC2::validInstanceTypes::checkInstanceType
  has Str    $.instanceType        is xml-element    is xml-skip-null          is rw;   #=  sub:Amazon::AWS::EC2::validInstanceTypes::checkInstanceType
  has Str    $.Platform            is xml-element    is xml-skip-null          is rw;
  has Str    $.platform            is xml-element    is xml-skip-null          is rw;
  has Str    $.Scope               is xml-element    is xml-skip-null          is rw;   #=  Availability Zone | Region
  has Str    $.scope               is xml-element    is xml-skip-null          is rw;   #=  Availability Zone | Region
}
