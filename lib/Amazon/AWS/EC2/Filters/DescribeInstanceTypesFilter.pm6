use v6.d;

use XML::Class;

use Amazon::AWS::Roles::Base;
use Amazon::AWS::Roles::Eqv;

# ebs-info.ebs-optimized-info.baseline-bandwidth-in-mbps - The baseline bandwidth performance for an EBS-optimized instance type, in Mbps.
# ebs-info.ebs-optimized-info.baseline-iops - The baseline input/output storage operations per second for an EBS-optimized instance type.
# ebs-info.ebs-optimized-info.baseline-throughput-in-mbps - The baseline throughput performance for an EBS-optimized instance type, in MB/s.
# ebs-info.ebs-optimized-info.maximum-bandwidth-in-mbps - The maximum bandwidth performance for an EBS-optimized instance type, in Mbps.
# ebs-info.ebs-optimized-info.maximum-iops - The maximum input/output storage operations per second for an EBS-optimized instance type.
# ebs-info.ebs-optimized-info.maximum-throughput-in-mbps - The maximum throughput performance for an EBS-optimized instance type, in MB/s.
class Amazon::AWS::EC2::Filters::DescribeInstanceTypesFilter::EBSOptimizedInfoFilter
  does XML::Class[xml-element => 'ebs-optimized-info']
{
  also does Amazon::AWS::Roles::Base;
  also does Amazon::AWS::Roles::Eqv;

  has Int $.baseline-bandwidth-in-mbps  is rw;
  has Int $.baseline-iops               is rw;
  has Int $.baseline-throughput-in-mbps is rw;
  has Int $.maximum-bandwidth-in-mbps   is rw;
  has Int $.maximum-iops                is rw;
  has Int $.maximum-throughput-in-mbps  is rw;
}

constant EBSOptimizedInfoFilter = Amazon::AWS::EC2::Filters::DescribeInstanceTypesFilter::EBSOptimizedInfoFilter;

# ebs-info.ebs-optimized-support - Indicates whether the instance type is EBS-optimized (supported | unsupported | default).
# ebs-info.encryption-support - Indicates whether EBS encryption is supported (supported | unsupported).
# ebs-info.nvme-support - Indicates whether non-volatile memory express (NVMe) is supported for EBS volumes (required | supported | unsupported).
class Amazon::AWS::EC2::Filters::DescribeInstanceTypesFilter::EBSInfoFilter
  does XML::Class[xml-element => 'ebs-info']
{
  also does Amazon::AWS::Roles::Base;
  also does Amazon::AWS::Roles::Eqv;

  has EBSOptimizedInfoFilter $.ebs-optimized-info    is rw;
  has Str                    $.ebs-optimized-support is rw;  #= supported | unsupported | default
  has Str                    $.encryption-support    is rw;  #= supported | unsupported
  has Str                    $.nvme-support          is rw;  #= required | supported | unsupported
}

constant EBSInfoFilter = Amazon::AWS::EC2::Filters::DescribeInstanceTypesFilter::EBSInfoFilter;

# instance-storage-info.disk.count - The number of local disks.
# instance-storage-info.disk.size-in-gb - The storage size of each instance storage disk, in GB.
# instance-storage-info.disk.type - The storage technology for the local instance storage disks (hdd | ssd).
# instance-storage-info.total-size-in-gb - The total amount of storage available from all local instance storage, in GB.
# instance-storage-info.nvme-support - Indicates whether non-volatile memory express (NVMe) is supported for instance store (required | supported | unsupported).
class Amazon::AWS::EC2::Filters::DescribeInstanceTypes::DiskFilter
  does XML::Class[xml-element => 'disk']
{
  also does Amazon::AWS::Roles::Base;
  also does Amazon::AWS::Roles::Eqv;

  has Int $.count      is rw;
  has Int $.size-in-gb is rw;
  has Str $.type       is rw; #= hdd | ssd
}

constant DiskFilter = Amazon::AWS::EC2::Filters::DescribeInstanceTypes::DiskFilter;

class Amazon::AWS::EC2::Filters::DescribeInstanceTypes::InstanceStorageInfoFilter
  does XML::Class[xml-element => 'instance-storage-info']
{
  also does Amazon::AWS::Roles::Base;
  also does Amazon::AWS::Roles::Eqv;

  has DiskFilter $.disk             is rw;
  has Int        $.total-size-in-gb is rw;
  has Str        $.nvme-support     is rw; #= required | supported | unsupported
}

constant InstanceStorageInfoFilter = Amazon::AWS::EC2::Filters::DescribeInstanceTypes::InstanceStorageInfoFilter;

# memory-info.size-in-mib - The memory size.
class Amazon::AWS::EC2::Filters::DescribeInstanceTypes::MemoryInfoFilter
  does XML::Class[xml-element => 'memory-info']
{
  also does Amazon::AWS::Roles::Base;
  also does Amazon::AWS::Roles::Eqv;

  has Int $.memory-size is rw;
}

constant MemoryInfoFilter = Amazon::AWS::EC2::Filters::DescribeInstanceTypes::MemoryInfoFilter;

# network-info.efa-supported - Indicates whether the instance type supports Elastic Fabric Adapter (EFA) (true | false).
# network-info.ena-support - Indicates whether Elastic Network Adapter (ENA) is supported or required (required | supported | unsupported).
# network-info.ipv4-addresses-per-interface - The maximum number of private IPv4 addresses per network interface.
# network-info.ipv6-addresses-per-interface - The maximum number of private IPv6 addresses per network interface.
# network-info.ipv6-supported - Indicates whether the instance type supports IPv6 (true | false).
# network-info.maximum-network-interfaces - The maximum number of network interfaces per instance.
# network-info.network-performance - The network performance (for example, "25 Gigabit").
class Amazon::AWS::EC2::Filters::DescribeInstanceTypes::NetworkInfoFilter
  does XML::Class[xml-element => 'network-info']
{
  also does Amazon::AWS::Roles::Base;
  also does Amazon::AWS::Roles::Eqv;

  has Bool $.efa-supported                is rw;
  has Str  $.ena-support                  is rw;  #= required | supported | unsupported
  has Int  $.ipv4-addresses-per-interface is rw;
  has Int  $.ipv6-addresses-per-interface is rw;
  has Bool $.ipv6-supported               is rw;
  has Int  $.maximum-network-interfaces   is rw;
  has Str  $.network-performance          is rw;
}

constant NetworkInfoFilter = Amazon::AWS::EC2::Filters::DescribeInstanceTypes::NetworkInfoFilter;

class Amazon::AWS::EC2::Filters::DescribeInstanceTypes::ProcessorInfoFilter
  does XML::Class[xml-element => 'processor-info']
{
  also does Amazon::AWS::Roles::Base;
  also does Amazon::AWS::Roles::Eqv;

  # processor-info.supported-architecture - The CPU architecture (arm64 | i386 | x86_64).
  # processor-info.sustained-clock-speed-in-ghz - The CPU clock speed, in GHz.
  has Str $.supported-architecture       is rw; #= arm64 | i386 | x86_64
  has Num $.sustained-clock-speed-in-ghz is rw;
}

constant ProcessorInfoFilter = Amazon::AWS::EC2::Filters::DescribeInstanceTypes::ProcessorInfoFilter;

class Amazon::AWS::EC2::Filters::DescribeInstanceTypes::VCPUInfoFilter
  does XML::Class[xml-element => 'vcpu-info']
{
  also does Amazon::AWS::Roles::Base;
  also does Amazon::AWS::Roles::Eqv;

  # default-cores - The default number of cores for the instance type.
  # default-threads-per-core - The default number of threads per core for the instance type.
  # default-vcpus - The default number of vCPUs for the instance type.
  # valid-cores - The number of cores that can be configured for the instance type.
  # valid-threads-per-core - The number of threads per core that can be configured for the instance type. For example, "1" or "1,2".

  has Int $.default-cores             is rw;
  has Int $.default-threads-per-core  is rw;
  has Int $.default-vcpus             is rw;
  has Int $.valid-cores               is rw;
  has Str $.valid-threads-per-core    is rw;
}

constant VCPUInfoFilter = Amazon::AWS::EC2::Filters::DescribeInstanceTypes::VCPUInfoFilter;

class Amazon::AWS::EC2::Filters::DescribeInstanceTypesFilter is export
  does XML::Class[xml-element => 'item']
{
  also does Amazon::AWS::Roles::Base;
  also does Amazon::AWS::Roles::Eqv;

  # auto-recovery-supported - Indicates whether auto recovery is supported (true | false).
  # bare-metal - Indicates whether it is a bare metal instance type (true | false).
  # burstable-performance-supported - Indicates whether it is a burstable performance instance type (true | false).
  # current-generation - Indicates whether this instance type is the latest generation instance type of an instance family (true | false).
  # ebs-info
  # free-tier-eligible - Indicates whether the instance type is eligible to use in the free tier (true | false).
  # hibernation-supported - Indicates whether On-Demand hibernation is supported (true | false).
  # hypervisor - The hypervisor (nitro | xen).
  # instance-storage-info
  # instance-storage-supported - Indicates whether the instance type has local instance storage (true | false).
  # instance-type - The instance type (for example c5.2xlarge or c5*).
  # memory-info
  # network-info
  # supported-root-device-type - The root device type (ebs | instance-store).
  # supported-usage-class - The usage class (on-demand | spot).
  # supported-virtualization-type - The virtualization type (hvm | paravirtual).

  has Bool                      $.auto-recovery-supported          is rw;
  has Bool                      $.bare-metal                       is rw;
  has Bool                      $.burstable-performance-supported  is rw;
  has Bool                      $.current-generation               is rw;
  has EBSInfoFilter             $.ebs-info                         is rw;
  has Bool                      $.free-tier-eligible               is rw;
  has Bool                      $.hibernation-supported            is rw;
  has Str                       $.hypervisor                       is rw;   #= nitro | xen
  has InstanceStorageInfoFilter $.instance-storage-info            is rw;
  has Bool                      $.instance-storage-supported       is rw;
  has Str                       $.instance-type                    is rw;   #= validate:Amazon::AWS::EC2::validInstanceTypes::checkInstanceType generate:Amazon::AWS::EC2::pickRandomInstanceTypes
  has MemoryInfoFilter          $.memory-info                      is rw;
  has NetworkInfoFilter         $.network-info                     is rw;
  has ProcessorInfoFilter       $.processor-info                   is rw;
  has Str                       $.supported-root-device-type       is rw;   #= ebs | instance-store
  has Str                       $.supported-usage-class            is rw;   #= on-demand | spot
  has Str                       $.supported-virtualization-type    is rw;   #= hvm | paravirtual
  has VCPUInfoFilter            $.vcpu-info                        is rw;

  # cw: This is in Amazon::AWS::Roles::Base, but what's there may be a bit slower
  #     than this. This alternative may be a better replacement...
  #
  # method pairs {
  #   do gather for .^attributes.sort( *.name.substr(2) ) {
  #     my ($n, $v) = ( .name.substr(2), .get_value(self) );
  #     next unless $v.defined;
  #     given $v {
  #       when Bool | Int | Str | Num {
  #         take Pair.new( $n, .get_value(self) );
  #       }
  #
  #       when .type.^shortname eq 'Tag' {
  #         for $v.Array {
  #           next unless [&&]($_, .defined, .value.defined);
  #           take Pair.new("tag:{ .key }", .value)
  #         }
  #       }
  #
  #       default {
  #         take Pair.new("{ $n }.{ .key }, .value) for .get_value(self).pairs;
  #       }
  #    }
  # }
}
