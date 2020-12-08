use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;

class Amazon::AWS::EC2::Types::InstanceMetadataOptionsRequest is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Str    $.HttpEndpoint               is xml-element    is xml-skip-null          is rw;   #=  disabled | enabled
  has Int    $.HttpPutResponseHopLimit    is xml-element    is xml-skip-null          is rw;
  has Str    $.HttpTokens                 is xml-element    is xml-skip-null          is rw;   #=  optional | required
}
