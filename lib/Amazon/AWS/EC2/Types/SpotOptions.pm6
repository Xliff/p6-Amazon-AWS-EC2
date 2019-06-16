use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;



class Amazon::AWS::EC2::Types::SpotOptions is export
  does XML::Class
{
  also is Amazon::AWS::EC2::Types::Base;

  has Str     $.allocationStrategy              is xml-element    is xml-skip-null          is rw;   #=  lowest-price | diversified
  has Str     $.instanceInterruptionBehavior    is xml-element    is xml-skip-null          is rw;   #=  hibernate | stop | terminate
  has Int     $.instancePoolsToUseCount         is xml-element    is xml-skip-null          is rw;
  has Int     $.minTargetCapacity               is xml-element    is xml-skip-null          is rw;
  has Bool    $.singleAvailabilityZone          is xml-element    is xml-skip-null          is rw;
  has Bool    $.singleInstanceType              is xml-element    is xml-skip-null          is rw;
}
