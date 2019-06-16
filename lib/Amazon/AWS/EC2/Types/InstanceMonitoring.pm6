use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;

use Amazon::AWS::EC2::Types::Monitoring;

class Amazon::AWS::EC2::Types::InstanceMonitoring is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Str           $.instanceId    is xml-element                is xml-skip-null          is rw; 
  has Monitoring    $.monitoring    is xml-element(:over-ride)    is xml-skip-null          is rw;
}
