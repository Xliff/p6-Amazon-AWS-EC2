#!/usr/bin/env raku

use Amazon::AWS::EC2::Action::DescribeInstances;
use Amazon::AWS::EC2::Filters::DescribeInstancesFilter;

use Amazon::AWS::EC2::Types::Tag;

my @valid-options;
sub MAIN (:$tags, :$help, *%filter is copy) {
  if $help {
    print $*USAGE;
    exit;
  }

  die "Invalid option name '{ $_ }'!" unless $_ eq @valid-options.any
    for %filter.keys;

  if $tags {
    %filter<tags> = $tags.split(',').map({
      my ($key, $value) = do {
        die "Tags must be in 'key:value' format!"
          unless $_ && /\w+ ':' \w+/;
        .split(':');
      }
      Pair.new($key, $value);
    }).Hash
  }

  my $filters = do if %filter<tags>.defined && %filter.elems == 1 {
    # Otherwise... OR
    %filter<tags>.pairs.map({
      DescribeInstancesFilter.new( tags => .Hash )
    });
  } else {
    DescribeInstancesFilter.new( |%filter ).Array;
  }

  if DescribeInstances.new(:$filters).run -> $r {
    .say for $r.reservations.map(
       *.instances.map({
         my $ret = .instanceId;
         my @name = gather for .tags {
           take .value if .key.lc eq 'name';
         }
         $ret ~= " \"{ @name[0] }\"" if +@name;
         $ret;
       }).flat
     ).flat
  } else {
    say 'No instances matching criterion found!';
  }

}

INIT @valid-options = <
  affinity
  architecture
  availability-zone
  client-token
  dns-name
  group-name
  host-id
  hipervisor
  image-id
  instance-id
  instance-lifecycle
  instance-state-code
  instance-state-name
  instance-type
  ip-address
  kernel-id
  key-name
  launch-index
  launch-time
  monitoring-state
  owner-id
  placement-group-name
  private-dns-name
  private-ip-address
  ami-product-code
  ramdisk-id
  reason
  requester-id
  reservation-id
  root-device-name
  root-device-type
  source-dest-check
  spot-instance-request-id
  state-reason-code
  state-reason-message
  subnet-id
>;
