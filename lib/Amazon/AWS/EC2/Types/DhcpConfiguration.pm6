use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;

use Amazon::AWS::EC2::Types::AttributeValue;

class Amazon::AWS::EC2::Types::DhcpConfiguration is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Str               $.key       is xml-element                                                    is rw; 
  has AttributeValue    @.values    is xml-element('item', :over-ride)  is xml-container('valueSet')  is rw; 
}
