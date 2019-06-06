use v6.d;

use XML::Class;

class Amazon::AWS::EC2::ElasticInferenceAcceleratorAssociation is export
  does XML::Class[xml-element => 'item']
{
  has Str $.elasticInferenceAccleratorArn               is xml-element is rw;
  has Str $.elasticInferenceAcceleratorAssociationId    is xml-element is rw;
  has Str $.elasticInferenceAcceleratorAssociationState is xml-element is rw;
  has Str $.elasticInferenceAcceleratorAssociationTime  is xml-element is rw;
}
