use v6.d;

use XML::Class;

use Amazon::AWS::Roles::Base;
use Amazon::AWS::Roles::Eqv;

class Amazon::AWS::EC2::Filters::DescribePrefixListsFilter is export
  does XML::Class[xml-element => 'item']
{
  also does Amazon::AWS::Roles::Base;
  also does Amazon::AWS::Roles::Eqv;

  has Str $.prefix-list-id   is xml-element is xml-skip-null is rw;
  has Str $.prefix-list-name is xml-element is xml-skip-null is rw;
}
