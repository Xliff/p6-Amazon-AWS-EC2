use v6.d;

use Amazon::AWS::Roles::Response;

use XML::Class;



class Amazon::AWS::EC2::Response::RebootInstancesResponse is export
  does XML::Class[xml-element => 'RebootInstancesResponse']
{
  also does Amazon::AWS::Roles::Response;

  has Bool    $.return    is xml-element          is rw; 
}