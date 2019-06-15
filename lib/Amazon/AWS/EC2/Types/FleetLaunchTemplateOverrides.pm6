use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;

use Amazon::AWS::EC2::Types::PlacementResponse;

class Amazon::AWS::EC2::Types::FleetLaunchTemplateOverrides is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Str                  $.availabilityZone    is xml-element                is xml-skip-null          is rw;
  has Str                  $.instanceType        is xml-element                is xml-skip-null          is rw;   #=  sub:Amazon::AWS::EC2::validInstanceTypes::checkInstanceType
  has Str                  $.maxPrice            is xml-element                is xml-skip-null          is rw;
  has PlacementResponse    $.placement           is xml-element(:over-ride)    is xml-skip-null          is rw;
  has Num                  $.priority            is xml-element                is xml-skip-null          is rw;
  has Str                  $.subnetId            is xml-element                is xml-skip-null          is rw;
  has Num                  $.weightedCapacity    is xml-element                is xml-skip-null          is rw;
}
