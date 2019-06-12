use v6.d;

use XML::Class;

use Amazon::AWS::Roles::Base;

class Amazon::AWS::EC2::Filters::DescribeKeyPairsFilter is export
  does XML::Class[xml-element => 'item']
{
  also does Amazon::AWS::Roles::Base;
  
  has Str $.fingerprint is xml-element is rw;
  has Str $.key-name    is xml-element is rw;
}
