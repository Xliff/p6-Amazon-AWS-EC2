use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;



class Amazon::AWS::EC2::Types::ClassicLinkDnsSupport is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Bool    $.classicLinkDnsSupported    is xml-element    is xml-skip-null          is rw; 
  has Str     $.vpcId                      is xml-element    is xml-skip-null          is rw; 
}