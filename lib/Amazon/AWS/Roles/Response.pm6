use v6.d;

use XML::Class;

role Amazon::AWS::Roles::Response {
  has $.requestId is xml-element;
}
