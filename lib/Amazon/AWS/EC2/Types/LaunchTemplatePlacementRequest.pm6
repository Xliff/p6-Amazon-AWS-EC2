use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;



class Amazon::AWS::EC2::Types::LaunchTemplatePlacementRequest is export
  does XML::Class
{
  also is Amazon::AWS::EC2::Types::Base;

  has Str    $.Affinity            is xml-element    is xml-skip-null          is rw;
  has Str    $.AvailabilityZone    is xml-element    is xml-skip-null          is rw;
  has Str    $.GroupName           is xml-element    is xml-skip-null          is rw;
  has Str    $.HostId              is xml-element    is xml-skip-null          is rw;
  has Str    $.SpreadDomain        is xml-element    is xml-skip-null          is rw;
  has Str    $.Tenancy             is xml-element    is xml-skip-null          is rw;   #=  default | dedicated | host
}
