use v6.d;

use XML::Class;

class Amazon::AWS::EC2::HibernationOptions is export
  does XML::Class[xml-element => 'hibernationOptions']
{
  has Bool $.configured is xml-element is rw;
}
