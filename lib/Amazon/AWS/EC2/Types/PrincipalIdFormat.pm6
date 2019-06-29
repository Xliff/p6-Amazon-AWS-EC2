use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;

use Amazon::AWS::EC2::Types::IdFormat;

class Amazon::AWS::EC2::Types::PrincipalIdFormat is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Str         $.arn        is xml-element                        is xml-skip-null                                       is rw; 
  has IdFormat    @.status     is xml-element('item', :over-ride)    is xml-skip-null    is xml-container('statusSet')      is rw; 
}
