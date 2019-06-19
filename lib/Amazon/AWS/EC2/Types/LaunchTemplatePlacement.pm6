use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;



class Amazon::AWS::EC2::Types::LaunchTemplatePlacement is export
  does XML::Class
{
  also is Amazon::AWS::EC2::Types::Base;

  has Str    $.affinity            is xml-element    is xml-skip-null          is rw;
  has Str    $.availabilityZone    is xml-element    is xml-skip-null          is rw;
  has Str    $.groupName           is xml-element    is xml-skip-null          is rw;
  has Str    $.hostId              is xml-element    is xml-skip-null          is rw;
  has Str    $.spreadDomain        is xml-element    is xml-skip-null          is rw;
  has Str    $.tenancy             is xml-element    is xml-skip-null          is rw;   #=  default | dedicated | host
}
