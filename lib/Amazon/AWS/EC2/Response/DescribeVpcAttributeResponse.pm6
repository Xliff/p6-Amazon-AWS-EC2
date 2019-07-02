use v6.d;

use Amazon::AWS::Roles::Response;

use XML::Class;

use Amazon::AWS::EC2::Types::AttributeBooleanValue;

class Amazon::AWS::EC2::Response::DescribeVpcAttributeResponse is export
  does XML::Class[xml-element => 'DescribeVpcAttributeResponse']
{
  also does Amazon::AWS::Roles::Response;

  has AttributeBooleanValue  $.enableDnsHostnames  is xml-element('enableDnsHostnames', :over-ride) is xml-skip-null is rw;
  has AttributeBooleanValue  $.enableDnsSupport    is xml-element('enableDnsSupport',   :over-ride) is xml-skip-null is rw;
  has Str                    $.nextToken           is xml-element                                   is xml-skip-null is rw;
  has Str                    $.vpcId               is xml-element                                   is xml-skip-null is rw;
}
