use v6.d;

use XML::Class;

use Amazon::AWS::Roles::Base;

class Amazon::AWS::EC2::Filters::DescribeTagsFilter::Tag
  does XML::Class[xml-element => 'item']
{
  also does Amazon::AWS::Roles::Base;
  
  has Str          $.key             is xml-element             is rw;
  has Str          $.value           is xml-element             is rw;
}

constant Tag          := Amazon::AWS::EC2::Filters::DescribeTagsFilter::Tag;

class Amazon::AWS::EC2::Filters::DescribeTagsFilter is export
  does XML::Class[xml-element => 'item']
{
  also does Amazon::AWS::Roles::Base;
  
  has Str $.key                                            is xml-element is rw;
  has Str $.resource-id                                    is xml-element is rw;
  has Str $.resource-type                                  is xml-element is rw;  #= customer-gateway | dedicated-host | dhcp-options | elastic-ip | fleet | fpga-image | image | instance | host-reservation | internet-gateway | launch-template | natgateway | network-acl | network-interface | reserved-instances | route-table | security-group | snapshot | spot-instances-request | subnet | volume | vpc | vpc-peering-connection | vpn-connection | vpn-gateway
  has Str $.value                                          is xml-element is rw;
  has Tag @.tags             is xml-container('tagSet')                   is rw;
}
