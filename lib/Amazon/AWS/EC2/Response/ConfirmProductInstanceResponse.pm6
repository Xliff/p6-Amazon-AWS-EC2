use v6.d;

use Amazon::AWS::Roles::Response;

use XML::Class;



class Amazon::AWS::EC2::Response::ConfirmProductInstanceResponse is export
  does XML::Class[xml-element => 'ConfirmProductInstanceResponse']
{
  also does Amazon::AWS::Roles::Response;

  has Str     $.ownerId    is xml-element     is xml-skip-null     is rw; 
  has Bool    $.return     is xml-element     is xml-skip-null     is rw; 
}
