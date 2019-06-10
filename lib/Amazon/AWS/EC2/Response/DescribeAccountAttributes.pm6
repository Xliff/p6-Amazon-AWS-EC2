use v6.d;

use Amazon::AWS::Roles::Response;

use XML::Class;

use Amazon::AWS::EC2::Types::AccountAttribute;

class Amazon::AWS::EC2::Types::Response::DescribeAccountAttributesResponse is export
  does XML::Class[xml-element => 'item']
{
  also does Amazon::AWS::Roles::Response;

  has AccountAttribute    @.accountAttributes    is xml-element    is xml-container('accountAttributeSet')      is rw; 
}