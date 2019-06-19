use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;

use Amazon::AWS::EC2::Types::AccountAttributeValue;

class Amazon::AWS::EC2::Types::AccountAttribute is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Str                      $.attributeName    is xml-element    is xml-skip-null                                               is rw; 
  has AccountAttributeValue    @.attributes       is xml-element    is xml-skip-null    is xml-container('attributeValueSet')      is rw; 
}