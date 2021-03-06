use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;



class Amazon::AWS::EC2::Types::PortRange is export
  does XML::Class
{
  also is Amazon::AWS::EC2::Types::Base;

  has Int    $.From    is xml-element    is xml-skip-null          is rw;
  has Int    $.from    is xml-element    is xml-skip-null          is rw;
  has Int    $.To      is xml-element    is xml-skip-null          is rw;
  has Int    $.to      is xml-element    is xml-skip-null          is rw;
}
