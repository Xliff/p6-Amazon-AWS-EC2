use v6.d;

use Method::Also;

use Amazon::AWS::Utils;
use Amazon::AWS::Roles::Eqv;

use XML::Class;

use Amazon::AWS::EC2::Response::CreateTagsResponse;

use Amazon::AWS::EC2::Types::Address;
use Amazon::AWS::EC2::Types::CapacityReservation;
use Amazon::AWS::EC2::Types::ClassicLinkInstance;
use Amazon::AWS::EC2::Types::ClientVpnEndpoint;
use Amazon::AWS::EC2::Types::CustomerGateway;
use Amazon::AWS::EC2::Types::DhcpOptions;
use Amazon::AWS::EC2::Types::FleetData;
use Amazon::AWS::EC2::Types::FpgaImage;
use Amazon::AWS::EC2::Types::Host;
use Amazon::AWS::EC2::Types::HostReservation;
use Amazon::AWS::EC2::Types::Image;
use Amazon::AWS::EC2::Types::Instance;
use Amazon::AWS::EC2::Types::InternetGateway;
use Amazon::AWS::EC2::Types::LaunchTemplate;
use Amazon::AWS::EC2::Types::NatGateway;
use Amazon::AWS::EC2::Types::NetworkAcl;
use Amazon::AWS::EC2::Types::NetworkInterface;
use Amazon::AWS::EC2::Types::ReservedInstances;
use Amazon::AWS::EC2::Types::ReservedInstancesListing;
use Amazon::AWS::EC2::Types::RouteTable;
use Amazon::AWS::EC2::Types::SecurityGroup;
use Amazon::AWS::EC2::Types::Snapshot;
use Amazon::AWS::EC2::Types::Subnet;
use Amazon::AWS::EC2::Types::Tag;
use Amazon::AWS::EC2::Types::TransitGateway;
use Amazon::AWS::EC2::Types::TransitGatewayRouteTable;
use Amazon::AWS::EC2::Types::Volume;
use Amazon::AWS::EC2::Types::Vpc;
use Amazon::AWS::EC2::Types::VpcEndpoint;
use Amazon::AWS::EC2::Types::VpnConnection;
use Amazon::AWS::EC2::Types::VpnGateway;

class Amazon::AWS::EC2::Action::CreateTags is export
  does XML::Class[xml-element => 'CreateTags']
{
  also does Amazon::AWS::Roles::Eqv;

  my $c = ::?CLASS.^shortname;

  has Bool    $.DryRun         is xml-element                        is xml-skip-null                                            is rw;
  has Str     @.ResourceIds    is xml-element('item', :over-ride)    is xml-skip-null    is xml-container('resourceIdsSet')      is rw;
  has Tag     @.Tags           is xml-element('item', :over-ride)    is xml-skip-null    is xml-container('tagsSet')             is rw;

  submethod BUILD (
        :$dryRun,
        :@resources,
        :@tags,
    # For testing purposes, ONLY!
        :$!DryRun       = False,
    Str :@!ResourceIds,
    Tag :@!Tags
  ) {
    if @resources {
      @!ResourceIds = @resources.map({
        do {
          when Str                         { $_                             }
          when Address                     { .allocationId                  }
          when CapacityReservation         { .capacityReservationId         }
          when ClassicLinkInstance         { .instanceId                    }
          when ClientVpnEndpoint           { .clientVpnEndpointId           }
          when CustomerGateway             { .customerGatewayId             }
          when DhcpOptions                 { .dhcpOptionsId                 }
          when FleetData                   { .fleetId                       }
          when FpgaImage                   { .fpgaImageId                   }
          when Host                        { .hostId                        }
          when HostReservation             { .hostReservationId             }
          when Image                       { .imageId                       }
          when Instance                    { .instanceId                    }
          when InternetGateway             { .internetGatewayId             }
          when LaunchTemplate              { .launchTemplateId              }
          when NatGateway                  { .natGatewayId                  }
          when NetworkAcl                  { .networkAclId                  }
          when NetworkInterface            { .networkInterfaceId            }
          when ReservedInstances           { .reservedInstancesId           }
          when ReservedInstancesListing    { .reservedInstancesListingId    }
          when RouteTable                  { .routeTableId                  }
          when SecurityGroup               { .securityGroupId               }
          when Snapshot                    { .snapshotId                    }
          when Subnet                      { .subnetId                      }
          when TransitGateway              { .transitGatewayId              }
          when TransitGatewayRouteTable    { .transitGatewayRouteTableId    }
          when Volume                      { .volumeId                      }
          when Vpc                         { .vpcId                         }
          when VpcEndpoint                 { .vpcEndpointId                 }
          when VpnConnection               { .vpnConnectionId               }
          when VpnGateway                  { .vpnGatewayId                  }

          default {
            die qq:to/DIE/.chomp;
            Invalid value passed to \@resources. Should only contain resource-compatible objects, but contains:
            { @resources.map( *.^name ).unique.join(', ') }
            DIE

          }
        }
      }).flat;
    }

    if @tags.all ~~ Tag {
      @!Tags = @tags
    } else {
      die qq:to/DIE/.chomp;
        Invalid value passed to \@tags. Should only contain Tag objects, but also contains:
        { @tags.map( *.^name ).grep(* ne 'Tag').unique.join(', ') }
        DIE
    }
  }

  method run (:$raw, :$region = default_region)
    is also<
      do
      execute
    >
  {
    my $cnt = 1;
    my @ResourceIdArgs;
    @ResourceIdArgs.push: Pair.new("ResourceId.{$cnt++}", $_) for @!ResourceIds;

    $cnt = 1;
    my @TagArgs;
    for @!Tags {
      @TagArgs.push: Pair.new("Tag.{ $cnt }.{ .key }", .value) for .pairs;
      $cnt++;
    }

    # Should already be sorted.
    my @args = (
      DryRun     => $!DryRun,
      |@ResourceIdArgs,
      |@TagArgs,
      Version    => '2016-11-15'
    );

    # XXX - Add error handling to makeRequest!
    my $xml = makeRequest(
      "?Action={ $c }&{ @args.map({ "{.key}={.value}" }).join('&') }",
      :$region
    );

    $raw ??
      $xml
      !!
      ::("Amazon::AWS::EC2::Response::{ $c }Response").from-xml($xml);
  }

}
