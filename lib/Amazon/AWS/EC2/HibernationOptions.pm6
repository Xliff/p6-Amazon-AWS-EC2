use v6.d;

use Amazon::AWS::EC2::Base;

use XML::Class;

class Amazon::AWS::EC2::HibernationOptions is export
  does XML::Class[xml-element => 'hibernationOptions']
{
  also is Amazon::AWS::EC2::Base;

  has Bool $.configured is xml-element is rw;
}