use v6.d;

use Method::Also;

use XML::Class;

use Amazon::AWS::Utils;
use Amazon::AWS::Roles::Eqv;

use Amazon::AWS::EC2::Types::TagSpecification;

use Amazon::AWS::EC2::Response::CreateVolumeResponse;

my %attributes;

class Amazon::AWS::EC2::Action::CreateVolume is export
  does XML::Class[xml-element => 'CreateVolume']
{
  also does Amazon::AWS::Roles::Eqv;

  my $c = ::?CLASS.^name.split('::')[* - 1];

  has Str               $.AvailabilityZone                                             is xml-element                      is xml-skip-null is rw;
  has Bool              $.DryRun                                                       is xml-element                      is xml-skip-null is rw;
  has Bool              $.Encrypted                                                    is xml-element                      is xml-skip-null is rw;
  has Int               $.Iops                                                         is xml-element                      is xml-skip-null is rw;
  has Str               $.KmsKeyId                                                     is xml-element                      is xml-skip-null is rw;
  has Int               $.Size                                                         is xml-element                      is xml-skip-null is rw;
  has Str               $.SnapshotId                                                   is xml-element                      is xml-skip-null is rw;
  has TagSpecification  @.TagSpecifications  is xml-container('tagSpecificationSet')   is xml-element('item', :over-ride)  is xml-skip-null is rw;
  has Str               $.VolumeType                                                   is xml-element                      is xml-skip-null is rw;  #= standard | io1 | gp2 | sc1 | st1

  submethod BUILD (
    :$availabilityZone,
    :$dryRun,
    :$encrypted,
    :$iops,
    :$kmsKeyId,
    :$size,
    :$snapshotId,
    :@tagSpecifications,
    :$volumeType,
    # For deserialization purposes, only!
    :$!AvailabilityZone  = '',
    :$!DryRun            = False,
    :$!Encrypted         = False,
    :$!Iops              = 32000,
    :$!KmsKeyId          = '',
    :$!Size              = 0,
    :$!SnapshotId        = '',
    :@!TagSpecifications,
    :$!VolumeType        = 'standard'
  ) {
    $!DryRun            = $dryRun if $dryRun;
    $!Iops              = $iops   if $iops;
    $!Size              = $size   if $size;

    if @tagSpecifications {
      @!TagSpecifications = do given @tagSpecifications {
        when .all ~~ TagSpecification
          { $_ }

        default {
          die qq:to/DIE/
          Invalid values passed to \@tagSpecifications. Elements must only consist of TagSpecifications, but also contains:
          { .grep( * !~~ TagSpecification ).map( *.^name ).join(', ') }
          DIE

        }
      }
    }

    die "Iops value ({ $iops }) is invalid!"
      unless %*ENV<P6_AWS_TESTING>.defined || $iops.defined && $!Iops ~~ 50..64000;

    $!KmsKeyId = $kmsKeyId
      if $kmsKeyId.defined && $kmsKeyId.trim.chars;
    $!AvailabilityZone = $availabilityZone
      if $availabilityZone.defined && $availabilityZone.trim.chars;
    $!SnapshotId = $snapshotId
      if $snapshotId.defined && $snapshotId.trim.chars;
    $!VolumeType = $volumeType
      if $volumeType.defined && $volumeType.trim.chars;

    my $vtDieMsg;
    $vtDieMsg = qq:to/DIE/ if $volumeType.defined && $volumeType.trim.chars;
    VolumeType is set to an invalid value ({ $volumeType }). It must be one of the following:
    { %attributes<VolumeType|Table> }
    DIE

    die $vtDieMsg unless $!VolumeType.chars.not ||
                         $!VolumeType ~~ self.getValidVolumeTypes.any;

    my $range = do given $!VolumeType {
      when 'gp2'         {   1..16384 }
      when 'io1'         {   4..16384 }
      when 'st1' | 'sc1' { 500..16384 }
      when 'standard'    {   1.. 1024 }
    };

    my $sDieMsg = qq:to/DIE/;
    Given size ({ $!Size }) is invalid for volume type { $!VolumeType }. Valid range is:
      { $range.min } - { $range.max }
    DIE

    die $sDieMsg unless %*ENV<P6_AWS_TESTING>.defined || $!Size.not || $!Size ~~ $range;

  }

  method run (:$raw)
    is also<
      do
      execute
    >
  {
    my @TagSpecArgs;
    my $cnt = 1;
    for @!TagSpecifications {
      @TagSpecArgs.push: Pair.new("TagSpecification.{$cnt++}.{.key}", .value)
        for .pairs;
    }

    # YYY - Other conditions for validity:
    #   AvailabilityZone   - End User validation
    #   Size vs SnapshotId - End User validation

    # @Args must be sorted by key name.
    my @args;
    @args.push:   (AvailabilityZone => $!AvailabilityZone)  if $!AvailabilityZone.chars;
    @args.push:   (DryRun           => $!DryRun)            if $!DryRun;
    @args.push:   (Encrypted        => $!Encrypted)         if $!Encrypted;
    @args.push:   (Iops             => $!Iops)              if $!Iops;
    @args.push:   (KmsKeyId         => $!KmsKeyId)          if $!KmsKeyId.chars;
    @args.push:   (Size             => $!Size)              if $!Size;
    @args.push:   (SnapshotId       => $!SnapshotId)        if $!SnapshotId.chars;
    @args.append: @TagSpecArgs                              if @TagSpecArgs;
    @args.push:   (Version          => '2016-11-15');
    @args.push:   (VolumeType       => $!VolumeType);

    # XXX - Add error handling to makeRequest!
    my $xml = makeRequest(
      "?Action={ $c }&{ @args.map({ "{.key}={.value}" }).join('&') }"
    );

    $raw ??
      $xml
      !!
      ::("Amazon::AWS::EC2::Response::{ $c }Response").from-xml($xml);
  }

  method getValidVolumeTypes {
    %attributes<VolumeType|ValidValues>.Array;
  }

}

BEGIN {
  %attributes = getAttributeData(
    Amazon::AWS::EC2::Action::CreateVolume
  );
}
