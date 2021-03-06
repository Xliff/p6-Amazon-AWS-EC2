use v6.d;

use Amazon::AWS::Roles::Response;

use XML::Class;

use Amazon::AWS::EC2::Types::IamInstanceProfileAssociation;

class Amazon::AWS::EC2::Response::AssociateIamInstanceProfileResponse is export
  does XML::Class[xml-element => 'AssociateIamInstanceProfileResponse']
{
  also does Amazon::AWS::Roles::Response;

  has IamInstanceProfileAssociation    $.iamInstanceProfileAssociation    is xml-element          is rw; 
}