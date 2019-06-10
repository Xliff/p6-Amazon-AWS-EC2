use v6.d;

use Amazon::AWS::Roles::Response;

use XML::Class;



class Amazon::AWS::EC2::Types::Response::ConfirmProductInstanceResponse is export
  does XML::Class[xml-element => 'item']
{
  also does Amazon::AWS::Roles::Response;

  has Str     $.ownerId    is xml-element          is rw; 
  has Bool    $.return     is xml-element          is rw; 
}