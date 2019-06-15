use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;

use Amazon::AWS::EC2::Types::PublicIpv4PoolRange;

class Amazon::AWS::EC2::Types::PublicIpv4Pool is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Str                    $.description                   is xml-element    is xml-skip-null                                                 is rw; 
  has PublicIpv4PoolRange    @.poolAddressRanges             is xml-element    is xml-skip-null    is xml-container('poolAddressRangeSet')      is rw; 
  has Str                    $.poolId                        is xml-element    is xml-skip-null                                                 is rw; 
  has Int                    $.totalAddressCount             is xml-element    is xml-skip-null                                                 is rw; 
  has Int                    $.totalAvailableAddressCount    is xml-element    is xml-skip-null                                                 is rw; 
}