use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;

class Amazon::AWS::EC2::Types::ProcessorInfo is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Str    @.supportedArchitectures      is xml-element('item', :over-ride)   is xml-skip-null    is xml-container('supportedArchitectures')      is rw;   #=  i386 | x86_64 | arm64
  has Num    $.sustainedClockSpeedInGhz    is xml-element                       is xml-skip-null                                                    is rw;
}
