use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;



class Amazon::AWS::EC2::Types::VpcPeeringConnectionOptionsDescription is export
  does XML::Class
{
  also is Amazon::AWS::EC2::Types::Base;

  has Bool    $.allowDnsResolutionFromRemoteVpc               is xml-element    is xml-skip-null          is rw;
  has Bool    $.allowEgressFromLocalClassicLinkToRemoteVpc    is xml-element    is xml-skip-null          is rw;
  has Bool    $.allowEgressFromLocalVpcToRemoteClassicLink    is xml-element    is xml-skip-null          is rw;
}
