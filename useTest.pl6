# use Amazon::AWS::EC2::Action::AllocateAddress;
# use Amazon::AWS::EC2::Action::CopySnapshot;
# use Amazon::AWS::EC2::Action::CreateDefaultSubnet;
# use Amazon::AWS::EC2::Action::CreateKeyPair;
# use Amazon::AWS::EC2::Action::CreateNetworkAclEntry;
# use Amazon::AWS::EC2::Action::CreatePlacementGroup;
# use Amazon::AWS::EC2::Action::CreateSnapshot;
# use Amazon::AWS::EC2::Action::DeleteKeyPair;
# use Amazon::AWS::EC2::Action::DeleteNetworkInterface;
# use Amazon::AWS::EC2::Action::DeleteSnapshot;
# use Amazon::AWS::EC2::Action::DescribeAggregateIdFormat;
# use Amazon::AWS::EC2::Action::DescribeFlowLogs;
# use Amazon::AWS::EC2::Action::DescribeIdFormat;
# use Amazon::AWS::EC2::Action::DescribeIdentityIdFormat;
# use Amazon::AWS::EC2::Action::DescribePrincipalIdFormat;
# use Amazon::AWS::EC2::Action::DescribeRegions;
# use Amazon::AWS::EC2::Action::DescribeSnapshotAttribute;
# use Amazon::AWS::EC2::Action::DescribeTags;
# use Amazon::AWS::EC2::Action::DescribeVpcEndpoints;
# use Amazon::AWS::EC2::Action::GetConsoleOutput;
# use Amazon::AWS::EC2::Action::GetConsoleScreenshot;
# use Amazon::AWS::EC2::Action::GetPasswordData;
# use Amazon::AWS::EC2::Action::ReleaseAddress;
# use Amazon::AWS::EC2::Action::CreateNetworkInterface;
# use Amazon::AWS::EC2::Action::CreateVolume;
# use Amazon::AWS::EC2::Action::DescribeAddresses;
# use Amazon::AWS::EC2::Action::DescribeDhcpOptions;
# use Amazon::AWS::EC2::Action::DescribeElasticGpus;
# use Amazon::AWS::EC2::Action::DescribeFpgaImageAttribute;
# use Amazon::AWS::EC2::Action::DescribeFpgaImages;
# use Amazon::AWS::EC2::Action::DescribeHostReservationOfferings;
# use Amazon::AWS::EC2::Action::DescribeIamInstanceProfileAssociations;
# use Amazon::AWS::EC2::Action::DescribeImageAttribute;
# use Amazon::AWS::EC2::Action::DescribeImages;
# use Amazon::AWS::EC2::Action::DescribeInstanceAttribute;
# use Amazon::AWS::EC2::Action::DescribeInstanceStatus;
# use Amazon::AWS::EC2::Action::DescribeInternetGateways;
# use Amazon::AWS::EC2::Action::DescribeKeyPairs;
# use Amazon::AWS::EC2::Action::DescribeLaunchTemplates;
# use Amazon::AWS::EC2::Action::DescribeNatGateways;
# use Amazon::AWS::EC2::Action::DescribeNetworkInterfaceAttribute;
# use Amazon::AWS::EC2::Action::DescribeNetworkInterfacePermissions;
# use Amazon::AWS::EC2::Action::DescribeNetworkInterfaces;
# use Amazon::AWS::EC2::Action::DescribePlacementGroups;
# use Amazon::AWS::EC2::Action::DescribePrefixLists;
# use Amazon::AWS::EC2::Action::DescribePublicIpv4Pools;
# use Amazon::AWS::EC2::Action::DescribeRouteTables;
# use Amazon::AWS::EC2::Action::DescribeSecurityGroupReferences;
# use Amazon::AWS::EC2::Action::DescribeSecurityGroups;
# use Amazon::AWS::EC2::Action::DescribeSnapshots;
# use Amazon::AWS::EC2::Action::DescribeSubnets;
# use Amazon::AWS::EC2::Action::DescribeVolumeAttribute;
# use Amazon::AWS::EC2::Action::DescribeVolumeModifications;
# use Amazon::AWS::EC2::Action::DescribeVolumeStatus;
# use Amazon::AWS::EC2::Action::DescribeVolumes;
# use Amazon::AWS::EC2::Action::DescribeVpcAttribute;
# use Amazon::AWS::EC2::Action::DescribeVpcEndpointConnectionNotifications;
# use Amazon::AWS::EC2::Action::DescribeVpcEndpointConnections;
# use Amazon::AWS::EC2::Action::RebootInstances;
# use Amazon::AWS::EC2::Action::StartInstances;
# use Amazon::AWS::EC2::Action::StopInstances;
# use Amazon::AWS::EC2::Action::CreateNetworkAcl;
# use Amazon::AWS::EC2::Action::CreateVpc;
# use Amazon::AWS::EC2::Action::DescribeAccountAttributes;
# use Amazon::AWS::EC2::Action::DescribeAvailabilityZones;
# use Amazon::AWS::EC2::Action::DescribeConversionTasks;

# use Amazon::AWS::EC2::Action::DescribeInstances;
# use Amazon::AWS::EC2::Action::DescribeNetworkAcls;
# use Amazon::AWS::EC2::Action::DescribeVpcs;

# use Amazon::AWS::EC2::Action::GetLaunchTemplateData;

# use Amazon::AWS::EC2::Action::DescribeLaunchTemplateVersions;

# %*ENV<P6_AWS_TESTING>=1;
# AllocateAddress.new.gist.say;
# CopySnapshot.new.gist.say;
# CreateDefaultSubnet.new.gist.say;
# CreateKeyPair.new.gist.say;
# CreateNetworkAclEntry.new.gist.say;
# CreatePlacementGroup.new.gist.say;
# CreateSnapshot.new.gist.say;
# DeleteKeyPair.new.gist.say;
# DeleteNetworkInterface.new.gist.say;
# DeleteSnapshot.new.gist.say;
# DescribeAggregateIdFormat.new.gist.say;
# DescribeFlowLogs.new.gist.say;
# DescribeIdFormat.new.gist.say;
# DescribeIdentityIdFormat.new.gist.say;
# DescribePrincipalIdFormat.new.gist.say;
# DescribeRegions.new.gist.say;

# my @modules = <
#   CopySnapshot
#   CreateVolume
# >;

my @modules = <
  CopySnapshot
  CreateDefaultSubnet
  CreateKeyPair
  CreateNetworkAclEntry
  CreatePlacementGroup
  CreateSnapshot
  DeleteKeyPair
  DeleteNetworkInterface
  DeleteSnapshot
  DescribeAggregateIdFormat
  DescribeFlowLogs
  DescribeIdFormat
  DescribeIdentityIdFormat
  DescribePrincipalIdFormat
  DescribeRegions
  DescribeSnapshotAttribute
  DescribeTags
  DescribeVpcEndpoints
  GetConsoleOutput
  GetConsoleScreenshot
  GetPasswordData
  ReleaseAddress
  CreateNetworkInterface
  CreateVolume
  DescribeAddresses
  DescribeDhcpOptions
  DescribeElasticGpus
  DescribeFpgaImageAttribute
  DescribeFpgaImages
  DescribeHostReservationOfferings
  DescribeIamInstanceProfileAssociations
  DescribeImageAttribute
  DescribeImages
  DescribeInstanceAttribute
  DescribeInstanceStatus
  DescribeInternetGateways
  DescribeKeyPairs
  DescribeLaunchTemplates
  DescribeNatGateways
  DescribeNetworkInterfaceAttribute
  DescribeNetworkInterfacePermissions
  DescribeNetworkInterfaces
  DescribePlacementGroups
  DescribePrefixLists
  DescribePublicIpv4Pools
  DescribeRouteTables
  DescribeSecurityGroupReferences
  DescribeSecurityGroups
  DescribeSnapshots
  DescribeSubnets
  DescribeVolumeAttribute
  DescribeVolumeModifications
  DescribeVolumeStatus
  DescribeVolumes
  DescribeVpcAttribute
  DescribeVpcEndpointConnectionNotifications
  DescribeVpcEndpointConnections
  RebootInstances
  StartInstances
  StopInstances
  CreateNetworkAcl
  CreateVpc
  DescribeAccountAttributes
  DescribeAvailabilityZones
  DescribeConversionTasks
  DescribeInstances
>;

my %class;
for @modules {
  .say;
  quietly {
    CATCH { 
      default { .message.say } 
    }
    %class{$_} := try require ::("Amazon::AWS::EC2::Action::$_");
  }
}

%class.gist.say;
say "Nil classes:";
for %class.kv -> $k, $v {
  $k.say if $v === Nil;
}
