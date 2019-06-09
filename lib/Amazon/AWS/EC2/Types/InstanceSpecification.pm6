use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;



class Amazon::AWS::EC2::Types::InstanceSpecification is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Bool    $.ExcludeBootVolume    is xml-element          is rw; 
  has Str     $.InstanceId           is xml-element          is rw; 
}