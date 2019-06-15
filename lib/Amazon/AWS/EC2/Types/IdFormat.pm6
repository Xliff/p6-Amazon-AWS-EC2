use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;



class Amazon::AWS::EC2::Types::IdFormat is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Str     $.deadline      is xml-element    is xml-skip-null          is rw; 
  has Str     $.resource      is xml-element    is xml-skip-null          is rw; 
  has Bool    $.useLongIds    is xml-element    is xml-skip-null          is rw; 
}