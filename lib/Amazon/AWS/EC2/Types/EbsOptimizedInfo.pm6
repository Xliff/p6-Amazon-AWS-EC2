use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;

class Amazon::AWS::EC2::Types::EbsOptimizedInfo is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Int    $.baselineBandwidthInMbps     is xml-element    is xml-skip-null          is rw;
  has Int    $.baselineIops                is xml-element    is xml-skip-null          is rw;
  has Num    $.baselineThroughputInMBps    is xml-element    is xml-skip-null          is rw;
  has Int    $.maximumBandwidthInMbps      is xml-element    is xml-skip-null          is rw;
  has Int    $.maximumIops                 is xml-element    is xml-skip-null          is rw;
  has Num    $.maximumThroughputInMBps     is xml-element    is xml-skip-null          is rw;
}
