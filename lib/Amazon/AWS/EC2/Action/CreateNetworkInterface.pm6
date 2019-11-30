use v6.d;

use Method::Also;

use XML::Class;

use Amazon::AWS::Roles::Eqv;
use Amazon::AWS::Utils;

use Amazon::AWS::EC2::Response::CreateNetworkInterfaceResponse;

my %attributes;

class Amazon::AWS::EC2::Action::CreateNetworkInterface is export
  does XML::Class[xml-element => 'CreateNetworkInterface']
{
  also does Amazon::AWS::Roles::Eqv;

  my $c = ::?CLASS.^name.split('::')[* - 1];

  has Str  $.Description                                                            is xml-element         is xml-skip-null is rw;
  has Bool $.DryRun                                                                 is xml-element         is xml-skip-null is rw;
  has Str  $.InterfaceType                                                          is xml-element         is xml-skip-null is rw;  #=  efa
  has Int  $.Ipv6AddressCount                                                       is xml-element         is xml-skip-null is rw;
  has Str  @.Ipv6Addresses                 is xml-container('ipv6AddressSet')       is xml-element('item') is xml-skip-null is rw;
  has Str  $.PrivateIpAddress                                                       is xml-element         is xml-skip-null is rw;
  has Str  @.PrivateIpAddresses            is xml-container('privateIpAddressSet')  is xml-element('item') is xml-skip-null is rw;
  has Int  $.SecondaryPrivateAddressCount                                           is xml-element         is xml-skip-null is rw;
  has Str  @.SecurityGroupIds              is xml-container('securityGroupIdSet')   is xml-element('item') is xml-skip-null is rw;
  has Str  $.SubnetId                                                               is xml-element         is xml-skip-null is rw;

  submethod BUILD (
    :$description,
    :$dryRun,
    :$interfaceType,
    :$ipv6AddressCount,
    :@ipv6Addresses,
    :$privateIpAddress,
    :@privateIpAddresses,
    :$secondaryPrivateAddressCount,
    :@securityGroupIds,
    :$subnetId,
    # For deserialization purposes, only!
    :$!Description                  = '',
    :$!DryRun                       = False,
    :$!InterfaceType                = '',
    :@!Ipv6Addresses,
    :$!Ipv6AddressCount             = 0,
    :$!PrivateIpAddress             = '',
    :@!PrivateIpAddresses,
    :$!SecondaryPrivateAddressCount = 0,
    :@!SecurityGroupIds,
    :$!SubnetId                     = ''
  ) {
    $!DryRun           = $dryRun           if $dryRun;
    $!Ipv6AddressCount = $ipv6AddressCount if $ipv6AddressCount.defined;
    @!SecurityGroupIds = @securityGroupIds if @securityGroupIds.elems;
    @!Ipv6Addresses    = @ipv6Addresses    if @ipv6Addresses.elems;

    $!SubnetId = $subnetId
      if $subnetId.defined && $subnetId.chars;
    $!Description= $description
      if $description.defined && $description.chars;
    $!InterfaceType = $interfaceType
      if $interfaceType.defined && $interfaceType.chars;
    $!PrivateIpAddress = $privateIpAddress
      if $privateIpAddress && $privateIpAddress.chars;
    $!SecondaryPrivateAddressCount = $secondaryPrivateAddressCount
      if $secondaryPrivateAddressCount.defined;

    my $dieMsg = qq:to/DIE/;
    Invalid Interface type passed! Should be one of:
    { %attributes<InterfaceType|Table> }
    DIE

    die $dieMsg unless $!InterfaceType.chars == 0 ||
                       $!InterfaceType ~~ self.getValidInterfaceTypes.any;
  }

  method run (:$raw)
    is also<
      do
      execute
    >
  {
    die "SubnetId is required. Please set this attribute before executing .run!"
      unless $!SubnetId.chars;

    my (@PrivateIpAddressArgs, @Ipv6AddressArgs, @SecurityGroupArgs, $cnt);

    $cnt = 1;
    @PrivateIpAddressArgs.push:
      Pair.new("PrivateIpAddresses.{$cnt++}", urlEncode($_))
        for @!PrivateIpAddresses;

    $cnt = 1;
    @Ipv6AddressArgs.push: Pair.new("Ipv6Addresses.{$cnt++}", urlEncode($_))
      for @!Ipv6Addresses;

    $cnt = 1;
    @SecurityGroupArgs.push:
      Pair.new("SecurityGroupId.{$cnt++}", urlEncode($_))
        for @!SecurityGroupIds;

    # @Args must be sorted by key name.
    my @args;
    @args.push:   (Description      => urlEncode($!Description))
      if $!Description.chars;
    @args.push:   (DryRun           => $!DryRun);
    @args.push:   (InterfaceType    => $!InterfaceType)    if $!InterfaceType.chars;
    @args.push:   (Ipv6AddressCount => $!Ipv6AddressCount) if $!Ipv6AddressCount;
    @args.append: @Ipv6AddressArgs                         if @Ipv6AddressArgs;
    @args.append: @PrivateIpAddressArgs                    if @PrivateIpAddressArgs;

    @args.push: (SecondaryPrivateAddressCount => $!SecondaryPrivateAddressCount)
      if $!SecondaryPrivateAddressCount;

    @args.append: @SecurityGroupArgs if @SecurityGroupArgs;

    @args.push: (SubnetId           => $!SubnetId);
    @args.push: (Version            => '2016-11-15');

    # XXX - Add error handling to makeRequest!
    my $xml = makeRequest(
      "?Action={ $c }&{ @args.map({ "{.key}={.value}" }).join('&') }"
    );

    $raw ??
      $xml
      !!
      ::("Amazon::AWS::EC2::Response::{ $c }Response").from-xml($xml);
  }

  method getValidInterfaceTypes {
    %attributes<InterfaceTypes|ValidValues>.Array;
  }

}

BEGIN {
  %attributes = getAttributeData(
    Amazon::AWS::EC2::Action::CreateNetworkInterface
  );
}
