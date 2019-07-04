use v6.d;

use XML::Class;

use Amazon::AWS::EC2::Types::SecurityGroupReference;

use Amazon::AWS::Roles::Response;

class Amazon::AWS::EC2::Response::DescribeSecurityGroupReferencesResponse is export
  does XML::Class[
    xml-element   => 'DescribeSecurityGroupsReferencesResponse',
    xml-namespace => 'http://ec2.amazonaws.com/doc/2016-11-15/'
  ]
{
  also does Amazon::AWS::Roles::Response;
  
  has SecurityGroupReference  @.references    is xml-container('securityGroupReferenceSet') is rw;
}
