use v6.d;

use Amazon::AWS::Roles::Response;

use XML::Class;

use Amazon::AWS::EC2::Types::ElasticGpus;

class Amazon::AWS::EC2::Response::DescribeElasticGpusResponse is export
  does XML::Class[xml-element => 'DescribeElasticGpusResponse']
{
  also does Amazon::AWS::Roles::Response;

  has ElasticGpus    @.elasticGpus    is xml-element    is xml-container('elasticGpuSet')      is rw; 
  has Int            $.maxResults     is xml-element                                           is rw; 
  has Str            $.nextToken      is xml-element                                           is rw; 
}