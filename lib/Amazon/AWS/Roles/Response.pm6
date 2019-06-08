use v6.d;

use XML::Class;

use Amazon::AWS::Roles::Eqv;

role Amazon::AWS::Roles::Response {
  also does Amazon::AWS::Roles::Eqv;

  has Str $.requestId is xml-element is rw;
}
