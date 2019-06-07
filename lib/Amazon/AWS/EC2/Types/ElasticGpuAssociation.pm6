use v6.c;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;

class Amazon::AWS::EC2::Types::ElasticGpuAssociation is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Str $.elasticGpuAssociationId    is xml-element is rw;
  has Str $.elasticGpuAssociationState is xml-element is rw;
  has Str $.elasticGpuAssociationTime  is xml-element is rw;
  has Str $.elasticGpuId               is xml-element is rw;
}
