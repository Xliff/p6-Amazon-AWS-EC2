use v6.d;

use Amazon::AWS::Roles::Response;

use XML::Class;



class Amazon::AWS::EC2::Response::CreateSecurityGroupResponse is export
  does XML::Class[xml-element => 'CreateSecurityGroupResponse']
{
  also does Amazon::AWS::Roles::Response;

  has Str    $.groupId    is xml-element          is rw; 
}