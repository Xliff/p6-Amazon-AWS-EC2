use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;



class Amazon::AWS::EC2::Types::LaunchTemplateOverrides is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Str    $.AvailabilityZone    is xml-element    is xml-skip-null          is rw;
  has Str    $.availabilityZone    is xml-element    is xml-skip-null          is rw;
  has Str    $.InstanceType        is xml-element    is xml-skip-null          is rw;   #= sub:Amazon::AWS::EC2::validInstanceTypes::checkInstanceType
  has Str    $.instanceType        is xml-element    is xml-skip-null          is rw;   #= sub:Amazon::AWS::EC2::validInstanceTypes::checkInstanceType
  has Num    $.Priority            is xml-element    is xml-skip-null          is rw;
  has Num    $.priority            is xml-element    is xml-skip-null          is rw;
  has Str    $.SpotPrice           is xml-element    is xml-skip-null          is rw;
  has Str    $.spotPrice           is xml-element    is xml-skip-null          is rw;
  has Str    $.SubnetId            is xml-element    is xml-skip-null          is rw;
  has Str    $.subnetId            is xml-element    is xml-skip-null          is rw;
  has Num    $.WeightedCapacity    is xml-element    is xml-skip-null          is rw;
  has Num    $.weightedCapacity    is xml-element    is xml-skip-null          is rw;
}
