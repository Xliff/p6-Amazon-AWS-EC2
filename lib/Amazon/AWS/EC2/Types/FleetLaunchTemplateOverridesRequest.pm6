use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;

use Amazon::AWS::EC2::Types::Placement;

class Amazon::AWS::EC2::Types::FleetLaunchTemplateOverridesRequest is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Str          $.AvailabilityZone    is xml-element          is rw;
  has Str          $.InstanceType        is xml-element          is rw;   #=  A valid instance type
  has Str          $.MaxPrice            is xml-element          is rw;
  has Placement    $.Placement           is xml-element          is rw;
  has Num          $.Priority            is xml-element          is rw;
  has Str          $.SubnetId            is xml-element          is rw;
  has Num          $.WeightedCapacity    is xml-element          is rw;
}
