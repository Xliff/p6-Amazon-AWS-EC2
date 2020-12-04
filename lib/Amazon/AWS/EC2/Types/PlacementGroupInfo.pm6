use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;

class Amazon::AWS::EC2::Types::PlacementGroupInfo is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Str    @.supportedStrategies  is xml-element('item', :over-ride)      is xml-skip-null    is xml-container('supportedStrategySet')      is rw;   #=  cluster | partition | spread
}
