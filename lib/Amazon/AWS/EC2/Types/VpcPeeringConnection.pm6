use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;

use Amazon::AWS::EC2::Types::Tag;
use Amazon::AWS::EC2::Types::VpcPeeringConnectionStateReason;
use Amazon::AWS::EC2::Types::VpcPeeringConnectionVpcInfo;

class Amazon::AWS::EC2::Types::VpcPeeringConnection is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has VpcPeeringConnectionVpcInfo        $.accepterVpcInfo           is xml-element(:over-ride)    is xml-skip-null                                    is rw;
  has Str                                $.expirationTime            is xml-element                is xml-skip-null                                    is rw;
  has VpcPeeringConnectionVpcInfo        $.requesterVpcInfo          is xml-element(:over-ride)    is xml-skip-null                                    is rw;
  has VpcPeeringConnectionStateReason    $.status                    is xml-element(:over-ride)    is xml-skip-null                                    is rw;
  has Tag                                @.tags                                                    is xml-skip-null    is xml-container('tagSet')      is rw; 
  has Str                                $.vpcPeeringConnectionId    is xml-element                is xml-skip-null                                    is rw;
}
