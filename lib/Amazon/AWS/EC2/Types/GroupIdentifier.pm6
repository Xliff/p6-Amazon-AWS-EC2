use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;



class Amazon::AWS::EC2::Types::GroupIdentifier is export
  does XML::Class
{
  also is Amazon::AWS::EC2::Types::Base;

  has Str    $.GroupId      is xml-element    is xml-skip-null          is rw;
  has Str    $.groupId      is xml-element    is xml-skip-null          is rw;
  has Str    $.GroupName    is xml-element    is xml-skip-null          is rw;
  has Str    $.groupName    is xml-element    is xml-skip-null          is rw;
}
