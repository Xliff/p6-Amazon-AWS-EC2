use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;



class Amazon::AWS::EC2::Types::LaunchTemplateSpotMarketOptionsRequest is export
  does XML::Class
{
  also is Amazon::AWS::EC2::Types::Base;

  has Int    $.BlockDurationMinutes            is xml-element    is xml-skip-null          is rw;
  has Str    $.InstanceInterruptionBehavior    is xml-element    is xml-skip-null          is rw;   #=  hibernate | stop | terminate
  has Str    $.MaxPrice                        is xml-element    is xml-skip-null          is rw;
  has Str    $.SpotInstanceType                is xml-element    is xml-skip-null          is rw;   #=  one-time | persistent
  has Str    $.ValidUntil                      is xml-element    is xml-skip-null          is rw;
}
