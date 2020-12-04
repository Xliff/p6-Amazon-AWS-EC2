use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;

class Amazon::AWS::EC2::Types::VCpuInfo is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Int    $.defaultCores             is xml-element                        is xml-skip-null                                             is rw;
  has Int    $.defaultThreadsPerCore    is xml-element                        is xml-skip-null                                             is rw;
  has Int    $.defaultVCpus             is xml-element                        is xml-skip-null                                             is rw;
  has Int    @.validCores               is xml-element('item', :over-ride)    is xml-skip-null    is xml-container('validCores')           is rw;
  has Int    @.validThreadsPerCore      is xml-element('item', :over-ride)    is xml-skip-null    is xml-container('validThreadsPerCore')  is rw;
}
