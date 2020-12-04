use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;

use Amazon::AWS::EC2::Types::NetworkCardInfo;

class Amazon::AWS::EC2::Types::NetworkInfo is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Int                $.defaultNetworkCardIndex      is xml-element                          is xml-skip-null                                          is rw;
  has Bool               $.efaSupported                 is xml-element                          is xml-skip-null                                          is rw;
  has Str                $.enaSupport                   is xml-element                          is xml-skip-null                                          is rw;   #=  unsuppquired
  has Int                $.ipv4AddressesPerInterface    is xml-element                          is xml-skip-null                                          is rw;
  has Int                $.ipv6AddressesPerInterface    is xml-element                          is xml-skip-null                                          is rw;
  has Bool               $.ipv6Supported                is xml-element                          is xml-skip-null                                          is rw;
  has Int                $.maximumNetworkCards          is xml-element                          is xml-skip-null                                          is rw;
  has Int                $.maximumNetworkInterfaces     is xml-element                          is xml-skip-null                                          is rw;
  has NetworkCardInfo    @.networkCards                 is xml-element('item', :over-ride)      is xml-skip-null    is xml-container('networkCardSet')    is rw;
  has Str                $.networkPerformance           is xml-element                          is xml-skip-null                                          is rw;
}
