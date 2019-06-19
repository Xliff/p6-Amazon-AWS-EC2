use v6.d;

use Amazon::AWS::Roles::Response;

use XML::Class;

use Amazon::AWS::EC2::Types::IamInstanceProfileAssociation;

class Amazon::AWS::EC2::Response::DescribeIamInstanceProfileAssociationsResponse is export
  does XML::Class[xml-element => 'DescribeIamInstanceProfileAssociationsResponse']
{
  also does Amazon::AWS::Roles::Response;

  has IamInstanceProfileAssociation    @.iamInstanceProfileAssociations    is xml-element    is xml-container('iamInstanceProfileAssociationSet')      is rw; 
  has Str                              $.nextToken                         is xml-element                                                              is rw; 
}