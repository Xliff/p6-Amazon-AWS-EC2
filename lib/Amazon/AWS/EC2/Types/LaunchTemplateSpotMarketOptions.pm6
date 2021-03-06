use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;



class Amazon::AWS::EC2::Types::LaunchTemplateSpotMarketOptions is export
  does XML::Class
{
  also is Amazon::AWS::EC2::Types::Base;

  has Int    $.blockDurationMinutes            is xml-element    is xml-skip-null          is rw;
  has Str    $.instanceInterruptionBehavior    is xml-element    is xml-skip-null          is rw;   #=  hibernate | stop | terminate
  has Str    $.maxPrice                        is xml-element    is xml-skip-null          is rw;
  has Str    $.spotInstanceType                is xml-element    is xml-skip-null          is rw;   #=  one-time | persistent
  has Str    $.validUntil                      is xml-element    is xml-skip-null          is rw;
}
