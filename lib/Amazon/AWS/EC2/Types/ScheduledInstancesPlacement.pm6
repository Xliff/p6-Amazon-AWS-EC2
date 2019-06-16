use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;



class Amazon::AWS::EC2::Types::ScheduledInstancesPlacement is export
  does XML::Class
{
  also is Amazon::AWS::EC2::Types::Base;

  has Str    $.AvailabilityZone    is xml-element    is xml-skip-null          is rw;
  has Str    $.GroupName           is xml-element    is xml-skip-null          is rw;
}
