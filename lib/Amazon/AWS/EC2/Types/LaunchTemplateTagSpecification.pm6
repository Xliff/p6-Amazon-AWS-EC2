use v6.d;

# use XML::Class;

# use Amazon::AWS::EC2::Types::Base;
# use Amazon::AWS::EC2::Types::Tag;

use Amazon::AWS::Utils;


# my %attributes;

class Amazon::AWS::EC2::Types::LaunchTemplateTagSpecification is export
  # does XML::Class[xml-element => 'item']
{
  # also is Amazon::AWS::EC2::Types::Base;

  # has Str    $.resourceType    is xml-element    is xml-skip-null                                    is rw;   #=  client-vpn-endpoint | customer-gateway | dedicated-host | dhcp-options | elastic-ip | fleet | fpga-image | host-reservation | image | instance | internet-gateway | launch-template | natgateway | network-acl | network-interface | reserved-instances | route-table | security-group | snapshot | spot-instances-request | subnet | transit-gateway | transit-gateway-attachment | transit-gateway-route-table | volume | vpc | vpc-peering-connection | vpn-connection | vpn-gateway
  # has Tag    @.tags                              is xml-skip-null    is xml-container('tagSet')      is rw;

  # method getValidResourceTypes {
  #   %attributes<ResourceType|ValidValues>.Array;
  # }

}

# BEGIN {
#   %attributes = getAttributeData(
#     Amazon::AWS::EC2::Types::LaunchTemplateTagSpecification
#   );
# }
