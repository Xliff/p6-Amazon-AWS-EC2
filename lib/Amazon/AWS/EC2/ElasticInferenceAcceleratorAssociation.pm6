use v6.d;

use Amazon::AWS::EC2::Base;

use XML::Class;

class Amazon::AWS::EC2::ElasticInferenceAcceleratorAssociation is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Base;

  has Str $.elasticInferenceAccleratorArn               is xml-element is rw;
  has Str $.elasticInferenceAcceleratorAssociationId    is xml-element is rw;
  has Str $.elasticInferenceAcceleratorAssociationState is xml-element is rw;
  has Str $.elasticInferenceAcceleratorAssociationTime  is xml-element is rw;
}