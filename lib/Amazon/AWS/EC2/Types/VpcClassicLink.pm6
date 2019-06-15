use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;

use Amazon::AWS::EC2::Types::Tag;

class Amazon::AWS::EC2::Types::VpcClassicLink is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Bool    $.classicLinkEnabled    is xml-element    is xml-skip-null                                    is rw; 
  has Tag     @.tags                  is xml-element    is xml-skip-null    is xml-container('tagSet')      is rw; 
  has Str     $.vpcId                 is xml-element    is xml-skip-null                                    is rw; 
}