use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;



class Amazon::AWS::EC2::Types::LaunchPermission is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Str    $.Group     is xml-element    is xml-skip-null          is rw;   #=  all
  has Str    $.group     is xml-element    is xml-skip-null          is rw;   #=  all
  has Str    $.UserId    is xml-element    is xml-skip-null          is rw; 
  has Str    $.userId    is xml-element    is xml-skip-null          is rw; 
}