use v6.c;

use XML::Class;

class Amazon::AWS::EC2::ElasticGpuAssociation is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Base;

  has Str $.elasticGpuAssociationId    is xml-element is rw;
  has Str $.elasticGpuAssociationState is xml-element is rw;
  has Str $.elasticGpuAssociationTime  is xml-element is rw;
  has Str $.elasticGpuId               is xml-element is rw;
}