use v6.d;

use Amazon::AWS::Roles::Response;

use XML::Class;

use Amazon::AWS::EC2::Types::InstanceTypeInfo;

class Amazon::AWS::EC2::Response::DescribeInstanceTypesResponse is export
  does XML::Class[xml-element => 'DescribeInstanceTypesResponse']
{
  also does Amazon::AWS::Roles::Response;

  has InstanceTypeInfo    @.instanceTypes    is xml-element('item', :over-ride)  is xml-skip-null    is xml-container('instanceTypeSet')      is rw;
  has Str                 $.nextToken        is xml-element                      is xml-skip-null                                             is rw;
}
