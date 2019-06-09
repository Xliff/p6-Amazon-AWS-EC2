use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;

use Amazon::AWS::EC2::Types::InstanceStatusDetails;

class Amazon::AWS::EC2::Types::InstanceStatusSummary is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has InstanceStatusDetails    @.details    is xml-element    is xml-container('details')      is rw; 
  has Str                      $.status     is xml-element                                     is rw;   #=  ok | impaired | insufficient-data | not-applicable | initializing
}