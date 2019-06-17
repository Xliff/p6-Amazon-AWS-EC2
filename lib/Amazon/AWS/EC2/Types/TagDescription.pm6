use v6.d;

use Amazon::AWS::EC2::Types::Base;

use XML::Class;



class Amazon::AWS::EC2::Types::TagDescription is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  has Str    $.key             is xml-element    is xml-skip-null          is rw;
  has Str    $.resourceId      is xml-element    is xml-skip-null          is rw;
  has Str    $.resourceType    is xml-element    is xml-skip-null          is rw;   #=  client-vpn-endpoint | customer-gateway | dedicated-host | dhcp-options | elastic-ip | fleet | fpga-image | host-reservation | image | instance | internet-gateway | launch-template | natgateway | network-acl | network-interface | reserved-instances | route-table | security-group | snapshot | spot-instances-request | subnet | transit-gateway | transit-gateway-attachment | transit-gateway-route-table | volume | vpc | vpc-peering-connection | vpn-connection | vpn-gateway
  has Str    $.value           is xml-element    is xml-skip-null          is rw;
}
