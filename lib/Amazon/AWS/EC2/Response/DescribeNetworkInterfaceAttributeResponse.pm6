use v6.d;

use Amazon::AWS::Roles::Response;

use XML::Class;

use Amazon::AWS::EC2::Types::AttributeValue;
use Amazon::AWS::EC2::Types::AttributeBooleanValue;
use Amazon::AWS::EC2::Types::GroupIdentifier;
use Amazon::AWS::EC2::Types::NetworkInterfaceAttachment;

class Amazon::AWS::EC2::Response::DescribeNetworkInterfaceAttributeResponse is export
  does XML::Class[xml-element => 'DescribeNetworkInterfaceAttributeResponse']
{
  also does Amazon::AWS::Roles::Response;

  has NetworkInterfaceAttachment $.attachment                                        is xml-element(:over-ride) is xml-skip-null is rw;
  has AttributeValue             $.description                                       is xml-element(:over-ride) is xml-skip-null is rw;
  has GroupIdentifier            @.groups              is xml-container('groupSet')                             is xml-skip-null is rw;
  has Str                        $.networkInterfaceId                                is xml-element             is xml-skip-null is rw;
  has AttributeBooleanValue      $.sourceDestCheck                                   is xml-element(:over-ride) is xml-skip-null is rw;
}
