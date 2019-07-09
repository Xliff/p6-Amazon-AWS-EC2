use v6.d;

use Amazon::AWS::Roles::Response;

use XML::Class;

class Amazon::AWS::EC2::Response::ErrorResponse::Error
  does XML::Class[xml-element => 'Error']
{
  has Str    $.Code                                       is xml-element          is xml-skip-null is rw;
  has Str    $.Message                                    is xml-element          is xml-skip-null is rw;
}

constant Error := Amazon::AWS::EC2::Response::ErrorResponse::Error;

class Amazon::AWS::EC2::Response::ErrorResponse is export
  does XML::Class[xml-element => 'Response']
{
  also does Amazon::AWS::Roles::Response;

  has Error  @.errors    is xml-container('Errors')                                                is rw; 
}
