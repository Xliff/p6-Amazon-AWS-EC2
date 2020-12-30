use v6.d;

use Amazon::AWS::Roles::Response;

use XML::Class;

use Amazon::AWS::EC2::Types::InstanceCreditSpecification;

class Amazon::AWS::EC2::Response::DescribeInstanceCreditSpecificationsResponse is export
  does XML::Class[xml-element => 'DescribeInstanceCreditSpecificationsResponse']
{
  also does Amazon::AWS::Roles::Response;

  has InstanceCreditSpecification    @.instanceCreditSpecifications    is xml-element('item', :over-ride)    is xml-skip-null    is xml-container('instanceCreditSpecificationSet')      is rw;
  has Str                            $.nextToken                       is xml-element                        is xml-skip-null                                                            is rw;
}
