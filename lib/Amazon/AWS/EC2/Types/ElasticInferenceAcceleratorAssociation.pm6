use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;



class Amazon::AWS::EC2::Types::ElasticInferenceAcceleratorAssociation is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Str    $.elasticInferenceAcceleratorArn                 is xml-element    is xml-skip-null          is rw; 
  has Str    $.elasticInferenceAcceleratorAssociationId       is xml-element    is xml-skip-null          is rw; 
  has Str    $.elasticInferenceAcceleratorAssociationState    is xml-element    is xml-skip-null          is rw; 
  has Str    $.elasticInferenceAcceleratorAssociationTime     is xml-element    is xml-skip-null          is rw; 
}