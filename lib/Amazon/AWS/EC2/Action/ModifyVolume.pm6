use v6.d;

use Method::Also;

use XML::Class;

use Amazon::AWS::Roles::Eqv;
use Amazon::AWS::Utils;

use Amazon::AWS::EC2::Response::ModifyVolumeResponse;

my %attributes;

class Amazon::AWS::EC2::Action::ModifyVolume is export
  does XML::Class[xml-element => 'ModifyVolume']
{
  also does Amazon::AWS::Roles::Eqv;

  my $c = ::?CLASS.^shortname;

  has Bool              $.DryRun                                                       is xml-element                      is xml-skip-null is rw;
  has Int               $.Iops                                                         is xml-element                      is xml-skip-null is rw;
  has Bool              $.MultiAttachedEnabled                                         is xml-element                      is xml-skip-null is rw;
  has Int               $.Size                                                         is xml-element                      is xml-skip-null is rw;
  has Int               $.Throughput                                                   is xml-element                      is xml-skip-null is rw;
  has Str               $.VolumeId                                                     is xml-element                      is xml-skip-null is rw;
  has Str               $.VolumeType                                                   is xml-element                      is xml-skip-null is rw;  #= standard | io1 | io2 | gp2 | sc1 | st1 | gp3

  submethod BUILD (
    :$dryRun,
    :$iops,
    :$multiAttachedEnabled,
    :$size,
    :$throughput,
    :$volumeId,
    :$volumeType,
    # For deserialization purposes, only!
    :$!DryRun,
    :$!Iops,
    :$!MultiAttachedEnabled,
    :$!Size,
    :$!Throughput,
    :$!VolumeId,
    :$!VolumeType
  ) {
    $!DryRun               = $dryRun               if $dryRun;
    $!Iops                 = $iops                 if $iops;
    $!Size                 = $size                 if $size;
    $!MultiAttachedEnabled = $multiAttachedEnabled if $multiAttachedEnabled;
    $!Throughput           = $throughput           if $throughput;
    $!VolumeId             = $volumeId             if $volumeId;
    $!VolumeType           = $volumeType           if $volumeType;

    die "Iops value ({ $!Iops }) is invalid!"
      unless %*ENV<P6_AWS_TESTING>.defined || $!Iops ~~ 50..64000;

    my $vtDieMsg;
    $vtDieMsg = qq:to/DIE/ if $volumeType.defined && $volumeType.trim.chars;
    VolumeType is set to an invalid value '{ $!VolumeType }'. It must be one of the following:
    { %attributes<VolumeType|Table> }
    DIE

    die $vtDieMsg unless $!VolumeType.chars.not ||
                         $!VolumeType ~~ self.getValidVolumeTypes.any;

    my $range = do given $!VolumeType {
      when 'gp2' | 'gp3' {   1..16384 }
      when 'io1'         {   4..16384 }
      when 'st1' | 'sc1' { 500..16384 }
      when 'standard'    {   1.. 1024 }
    };

    my $sDieMsg = qq:to/DIE/;
    Given size ({ $!Size }) is invalid for volume type { $!VolumeType }. Valid range is:
      { $range.min } - { $range.max }
    DIE
    die $sDieMsg unless %*ENV<P6_AWS_TESTING>.defined ||
                        $!Size.defined.not            ||
                        $!Size ~~ $range;

    $range = do given $!VolumeType {
      when 'gp3' { 3000..16000 }
      when 'io1' {  100..64000 }
      when 'io2' {  100..64000 }

      default    {    0..0     }
    }
    my $iDieMsg = qq:to/DIE/;
    Given iops ({ $!Iops }) is invalid for volume type { $!VolumeType }. Valid range is:
      { $range.min } - { $range.max }
    DIE
    die $iDieMsg unless %*ENV<P6_AWS_TESTING>.defined ||
                        $!Iops.defined.not            ||
                        $!Iops ~~ $range;
  }

  method run (:$raw)
    is also<
      do
      execute
    >
  {
    # @Args must be sorted by key name.
    my @args;
    @args.push:   (DryRun               => $!DryRun)           if $!DryRun;
    @args.push:   (Iops                 => $!Iops)             if $!Iops;

    @args.push:   (MultiAttachedEnabled => $!MultiAttachedEnabled)
      if $!MultiAttachedEnabled;

    @args.push:   (Size                 => $!Size)             if $!Size;
    @args.push:   (Throughput           => $!Throughput)       if $!Throughput;
    @args.push:   (VolumeId             => $!VolumeId)         if $!VolumeId;
    @args.push:   (VolumeType           => $!VolumeType);

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
    Amazon::AWS::EC2::Action::ModifyVolume
  );
}
