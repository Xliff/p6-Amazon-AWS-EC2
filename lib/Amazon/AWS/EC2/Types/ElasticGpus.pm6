use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;

use Amazon::AWS::EC2::Types::ElasticGpuHealth;

class Amazon::AWS::EC2::Types::ElasticGpus is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Str                 $.availabilityZone    is xml-element                                    is xml-skip-null          is rw; 
  has ElasticGpuHealth    $.elasticGpuHealth    is xml-element('elasticGpuHealth', :over-ride)    is xml-skip-null          is rw; 
  has Str                 $.elasticGpuId        is xml-element                                    is xml-skip-null          is rw; 
  has Str                 $.elasticGpuState     is xml-element                                    is xml-skip-null          is rw;   #=  ATTACHED
  has Str                 $.elasticGpuType      is xml-element                                    is xml-skip-null          is rw; 
  has Str                 $.instanceId          is xml-element                                    is xml-skip-null          is rw; 
}
