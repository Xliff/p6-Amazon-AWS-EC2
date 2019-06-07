use v6.c;

use Amazon::AWS::EC2::Base;

use XML::Class;

# Amazon makes this difficult by distinguishing the
# response and request by whether the first letter of the attribute
# is capitalized.

# This makes shit harder on the people writing code in other languages.
# For me... it just means 2 extra lines. :)

class Amazon::AWS::EC2::GroupIdentifier is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Base;

  # Request;
  has Str $.GroupId   is xml-element is rw;
  has Str $.GroupName is xml-element is rw;

  # Response
  has Str $.groupId   is xml-element is rw;
  has Str $.groupName is xml-element is rw;
}
