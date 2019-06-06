use v6.d;

use Amazon::AWS::EC2::Base;

use XML::Class;

class Amazon::AWS::EC2::IamInstanceProfile is export
  does XML::Class[xml-element => 'iamInstanceProfile']
{
  also is Amazon::AWS::EC2::Base;

  has Str $.arn is xml-element is rw;
  has Str $.id  is xml-element is rw;
}