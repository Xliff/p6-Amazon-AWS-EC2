use v6.d;

use Method::Also;
use XML::Class;

use Amazon::AWS::EC2::Types::BlockDeviceMapping;
use Amazon::AWS::EC2::Types::CapacityReservationSpecification;
use Amazon::AWS::EC2::Types::CpuOptionsRequest;
use Amazon::AWS::EC2::Types::CreditSpecificationRequest;
use Amazon::AWS::EC2::Types::ElasticGpuSpecification;
use Amazon::AWS::EC2::Types::ElasticInferenceAccelerator;
use Amazon::AWS::EC2::Types::EnclaveOptionsRequest;
use Amazon::AWS::EC2::Types::HibernationOptionsRequest;
use Amazon::AWS::EC2::Types::IamInstanceProfileSpecification;
use Amazon::AWS::EC2::Types::InstanceMarketOptionsRequest;
use Amazon::AWS::EC2::Types::InstanceMetadataOptionsRequest;
use Amazon::AWS::EC2::Types::InstanceNetworkInterfaceSpecification;
use Amazon::AWS::EC2::Types::InstanceIpv6Address;
use Amazon::AWS::EC2::Types::LaunchTemplateSpecification;
use Amazon::AWS::EC2::Types::LicenseConfigurationRequest;
use Amazon::AWS::EC2::Types::Placement;
use Amazon::AWS::EC2::Types::RunInstancesMonitoringEnabled;
use Amazon::AWS::EC2::Types::TagSpecification;

use Amazon::AWS::EC2::Response::RunInstancesResponse;

use Amazon::AWS::EC2::Types::LaunchTemplate;

use Amazon::AWS::Utils;
use Amazon::AWS::Roles::Eqv;

class Amazon::AWS::EC2::Types::RunInstances is export
  does XML::Class[xml-element => 'item']
{
  also does Amazon::AWS::Roles::Eqv;

  my $c = ::?CLASS.^shortname;

  has Str                                   $.AdditionalInfo                       is xml-element                                  is xml-skip-null                                                           is rw;
  has BlockDeviceMapping                    @.BlockDeviceMapping                   is xml-element('item', :over-ride)              is xml-skip-null    is xml-container('blockDeviceMappingSet')              is rw;
  has CapacityReservationSpecification      $.CapacityReservationSpecification     is xml-element                                  is xml-skip-null                                                           is rw;
  has Str                                   $.ClientToken                          is xml-element                                  is xml-skip-null                                                           is rw;
  has CpuOptionsRequest                     $.CpuOptions                           is xml-element                                  is xml-skip-null                                                           is rw;
  has CreditSpecificationRequest            $.CreditSpecification                  is xml-element                                  is xml-skip-null                                                           is rw;
  has Bool                                  $.DisableApiTermination                is xml-element                                  is xml-skip-null                                                           is rw;
  has Bool                                  $.DryRun                               is xml-element                                  is xml-skip-null                                                           is rw;
  has Bool                                  $.EbsOptimized                         is xml-element                                  is xml-skip-null                                                           is rw;
  has ElasticGpuSpecification               @.ElasticGpuSpecification              is xml-element('item', :over-ride)              is xml-skip-null    is xml-container('elasticGpuSpecificationSet')         is rw;
  has ElasticInferenceAccelerator           @.ElasticInferenceAccelerator          is xml-element('item', :over-ride)              is xml-skip-null    is xml-container('elasticInferenceAcceleratorSet')     is rw;
  has EnclaveOptionsRequest                 $.EnclaveOptions                       is xml-element                                  is xml-skip-null                                                           is rw;
  has HibernationOptionsRequest             $.HibernationOptions                   is xml-element                                  is xml-skip-null                                                           is rw;
  has IamInstanceProfileSpecification       $.IamInstanceProfile                   is xml-element                                  is xml-skip-null                                                           is rw;
  has Str                                   $.ImageId                              is xml-element                                  is xml-skip-null                                                           is rw;
  has Str                                   $.InstanceInitiatedShutdownBehavior    is xml-element                                  is xml-skip-null                                                           is rw;  #=  stop | terminate
  has InstanceMarketOptionsRequest          $.InstanceMarketOptions                is xml-element                                  is xml-skip-null                                                           is rw;
  has Str                                   $.InstanceType                         is xml-element                                  is xml-skip-null                                                           is rw;  #= validation:Amazon::AWS::EC2::validInstanceTypes::checkInstanceType
  has InstanceIpv6Address                   @.Ipv6Address                          is xml-element('item', :over-ride)              is xml-skip-null    is xml-container('ipv6AddressSet')                     is rw;
  has Int                                   $.Ipv6AddressCount                     is xml-element                                  is xml-skip-null                                                           is rw;
  has Str                                   $.KernelId                             is xml-element                                  is xml-skip-null                                                           is rw;
  has Str                                   $.KeyName                              is xml-element                                  is xml-skip-null                                                           is rw;
  has                                       $.LaunchTemplate                       is xml-element                                  is xml-skip-null                                                           is rw;
  has LicenseConfigurationRequest           @.LicenseSpecification                 is xml-element('item', :over-ride)              is xml-skip-null    is xml-container('licenseSpecificationSet')            is rw;
  has Int                                   $.MaxCount                             is xml-element                                  is xml-skip-null                                                           is rw;
  has InstanceMetadataOptionsRequest        $.MetadataOptions                      is xml-element                                  is xml-skip-null                                                           is rw;
  has Int                                   $.MinCount                             is xml-element                                  is xml-skip-null                                                           is rw;
  has RunInstancesMonitoringEnabled         $.Monitoring                           is xml-element                                  is xml-skip-null                                                           is rw;
  has InstanceNetworkInterfaceSpecification @.NetworkInterface                     is xml-element('item', :over-ride)              is xml-skip-null    is xml-container('networkInterfaceSet')                is rw;
  has Placement                             $.Placement                            is xml-element                                  is xml-skip-null                                                           is rw;
  has Str                                   $.PrivateIpAddress                     is xml-element                                  is xml-skip-null                                                           is rw;
  has Str                                   $.RamdiskId                            is xml-element                                  is xml-skip-null                                                           is rw;
  has Str                                   @.SecurityGroup                        is xml-element('item', :over-ride)              is xml-skip-null    is xml-container('securityGroupSet')                   is rw;
  has Str                                   @.SecurityGroupId                      is xml-element('item', :over-ride)              is xml-skip-null    is xml-container('securityGroupIdSet')                 is rw;
  has Str                                   $.SubnetId                             is xml-element                                  is xml-skip-null                                                           is rw;
  has TagSpecification                      @.TagSpecification                     is xml-element('item', :over-ride)              is xml-skip-null    is xml-container('tagSpecificationSet')                is rw;

  # Must be Base-64 encoded!!
  has Str                                   $.UserData                             is xml-element                                  is xml-skip-null                                                           is rw;

  # cw: WHO MAKES INITIALIZERS LIKE THESE?! o_O   (well... now I do.. *sob*)

  submethod  BUILD (
    # Convenience params
    Int                                   :$count,
    # Attributes
    Str                                   :$additionalInfo,
                                          :@blockDeviceMapping,
    CapacityReservationSpecification      :$capacityReservationSpecification,
    Str                                   :$clientToken,
    CpuOptionsRequest                     :$cpuOptions,
    CreditSpecificationRequest            :$creditSpecification,
    Bool                                  :$disableApiTermination,
    Bool                                  :$dryRun,
    Bool                                  :$ebsOptimized,
                                          :@elasticGpuSpecification,
                                          :@elasticInferenceAccelerator,
    EnclaveOptionsRequest                 :$enclaveOptions,
    HibernationOptionsRequest             :$hibernationOptions,
    IamInstanceProfileSpecification       :$iamInstanceProfile,
    Str                                   :$imageId,
    Str                                   :$instanceInitiatedShutdownBehavior,
    InstanceMarketOptionsRequest          :$instanceMarketOptions,
    Str                                   :$instanceType,
                                          :@ipv6Address,
    Int                                   :$ipv6AddressCount,
    Str                                   :$kernelId,
    Str                                   :$keyName,
                                          :$launchTemplate,
                                          :@licenseSpecification,
    Int                                   :$maxCount,
    InstanceMetadataOptionsRequest        :$metadataOptions,
    Int                                   :$minCount,
    RunInstancesMonitoringEnabled         :$monitoring,
                                          :@networkInterface,
    Placement                             :$placement,
    Str                                   :$privateIpAddress,
    Str                                   :$ramdiskId,
    Str                                   :@securityGroup,
    Str                                   :@securityGroupId,
    Str                                   :$subnetId,
                                          :@tagSpecification,
    Str                                   :$userData,
    # For testing purposes, only!
    Str                                   :$!AdditionalInfo,
                                          :@!BlockDeviceMapping,
    CapacityReservationSpecification      :$!CapacityReservationSpecification,
    Str                                   :$!ClientToken,
    CpuOptionsRequest                     :$!CpuOptions,
    CreditSpecificationRequest            :$!CreditSpecification,
    Bool                                  :$!DisableApiTermination,
    Bool                                  :$!DryRun                            = False,
    Bool                                  :$!EbsOptimized,
                                          :@!ElasticGpuSpecification,
                                          :@!ElasticInferenceAccelerator,
    EnclaveOptionsRequest                 :$!EnclaveOptions,
    HibernationOptionsRequest             :$!HibernationOptions,
    IamInstanceProfileSpecification       :$!IamInstanceProfile,
    Str                                   :$!ImageId,
    Str                                   :$!InstanceInitiatedShutdownBehavior,
    InstanceMarketOptionsRequest          :$!InstanceMarketOptions,
    Str                                   :$!InstanceType,
                                          :@!Ipv6Address,
    Int                                   :$!Ipv6AddressCount,
    Str                                   :$!KernelId,
    Str                                   :$!KeyName,
    LaunchTemplateSpecification           :$!LaunchTemplate,
                                          :@!LicenseSpecification,
    Int                                   :$!MaxCount,
    InstanceMetadataOptionsRequest        :$!MetadataOptions,
    Int                                   :$!MinCount,
    RunInstancesMonitoringEnabled         :$!Monitoring,
                                          :@!NetworkInterface,
    Placement                             :$!Placement,
    Str                                   :$!PrivateIpAddress,
    Str                                   :$!RamdiskId,
    Str                                   :@!SecurityGroup,
    Str                                   :@!SecurityGroupId,
    Str                                   :$!SubnetId,
                                          :@!TagSpecification,
    Str                                   :$!UserData
  ) {
    $!AdditionalInfo                    = $additionalInfo                    if $additionalInfo;
    @!BlockDeviceMapping                = @blockDeviceMapping                if @blockDeviceMapping          && @blockDeviceMapping.all           ~~ BlockDeviceMapping;
    $!CapacityReservationSpecification  = $capacityReservationSpecification  if $capacityReservationSpecification;
    $!ClientToken                       = $clientToken                       if $clientToken;
    $!CpuOptions                        = $cpuOptions                        if $cpuOptions;
    $!CreditSpecification               = $creditSpecification               if $creditSpecification;
    $!DisableApiTermination             = $disableApiTermination             if $disableApiTermination;
    $!DryRun                            = $dryRun                            if $dryRun;
    $!EbsOptimized                      = $ebsOptimized                      if $ebsOptimized;
    @!ElasticGpuSpecification           = @elasticGpuSpecification           if @elasticGpuSpecification     && @elasticGpuSpecification.all      ~~ ElasticGpuSpecification;
    @!ElasticInferenceAccelerator       = @elasticInferenceAccelerator       if @elasticInferenceAccelerator && @elasticInferenceAccelerator.all  ~~ ElasticInferenceAccelerator;
    $!EnclaveOptions                    = $enclaveOptions                    if $enclaveOptions;
    $!HibernationOptions                = $hibernationOptions                if $hibernationOptions;
    $!IamInstanceProfile                = $iamInstanceProfile                if $iamInstanceProfile;
    $!ImageId                           = $imageId                           if $imageId;
    $!InstanceInitiatedShutdownBehavior = $instanceInitiatedShutdownBehavior if $instanceInitiatedShutdownBehavior;
    $!InstanceMarketOptions             = $instanceMarketOptions             if $instanceMarketOptions;
    $!InstanceType                      = $instanceType                      if $instanceType;
    @!Ipv6Address                       = @ipv6Address                       if @ipv6Address                 && @ipv6Address.all                  ~~ InstanceIpv6Address;
    $!Ipv6AddressCount                  = $ipv6AddressCount                  if $ipv6AddressCount;
    $!KernelId                          = $kernelId                          if $kernelId;
    $!KeyName                           = $keyName                           if $keyName;
    @!LicenseSpecification              = @licenseSpecification              if @licenseSpecification        && @licenseSpecification.all         ~~ LicenseConfigurationRequest;
    $!MaxCount                          = $maxCount                          if $maxCount;
    $!MetadataOptions                   = $metadataOptions                   if $metadataOptions;
    $!MinCount                          = $minCount                          if $minCount;
    $!Monitoring                        = $monitoring                        if $monitoring;
    @!NetworkInterface                  = @networkInterface                  if @networkInterface            && @networkInterface.all             ~~ InstanceNetworkInterfaceSpecification;
    $!Placement                         = $placement                         if $placement;
    $!PrivateIpAddress                  = $privateIpAddress                  if $privateIpAddress;
    $!RamdiskId                         = $ramdiskId                         if $ramdiskId;
    @!SecurityGroup                     = @securityGroup                     if @securityGroup               && @securityGroup.all                ~~ Str;
    @!SecurityGroupId                   = @securityGroupId                   if @securityGroupId             && @securityGroupId.all              ~~ Str;
    $!SubnetId                          = $subnetId                          if $subnetId;
    @!TagSpecification                  = @tagSpecification                  if @tagSpecification            && @tagSpecification.all             ~~ TagSpecification;
    $!UserData                          = $userData                          if $userData;

    with $launchTemplate {
      $!LaunchTemplate = do {
        when LaunchTemplateSpecification { $_ }

        when LaunchTemplate {
          LaunchTemplateSpecification.new(
            LaunchTemplateID   => .launchTemplateId,
            LaunchTemplateName => .launchTemplateName,
            Version            => .defaultVersionNumber.Str
          );
        }
      }
    }

    # Convenience param overrides individuals...
    $!MinCount = $!MaxCount             = $count                             if $count;
  }

  method run (:$raw = False)
    is also<
      do
      execute
    >
  {

    my (@BlockDeviceMappingArgs,          @ElasticGpuSpecificationArgs,
        @ElasticInferenceAcceleratorArgs, @Ipv6AddressArgs,
        @LicenseSpecificationArgs,        @NetworkInterfaceArgs,
        @TagSpecification,                @SecurityGroupArgs,
        @SecurityGroupIdArgs,             @TagSpecificationArgs,@arrays);

    @arrays = (@!BlockDeviceMapping,          @!ElasticGpuSpecification,
               @!ElasticInferenceAccelerator, @!Ipv6Address,
               @!LicenseSpecification,        @!NetworkInterface,
               @!TagSpecification);

    for @arrays -> $_ is raw {
      my \v = .VAR.name.substr(2);
      my $cnt = 1;
      ::("\@{ v }Args").push: Pair.new(
        "{ v }.{$cnt++}.{ .key }",
        .value
      ) for .pairs;
    }

    for (@!SecurityGroup, @!SecurityGroupId) -> $_ is raw {
      my \v = .VAR.name.substr(2);
      my $cnt = 1;
      ::("\@{ v }Args").push: Pair.new("{ v }.{$cnt++}", $_) for $_;
    }

    # Pairs in @args must be in alpha order, so they are created that way.
    my @args;
    @args.push: Pair.new('AdditionalInfo', $!AdditionalInfo) if $!AdditionalInfo;
    @args.append: |@BlockDeviceMappingArgs                   if @!BlockDeviceMapping;

    for
      $!CapacityReservationSpecification,
      $!ClientToken,
      $!CpuOptions,
      $!CreditSpecification,
      $!DisableApiTermination
    -> $_ is raw {
      @args.push: Pair.new( .VAR.name, $_ ) if $_
    }

    @args.push: Pair.new('DryRun', $!DryRun);

    for
      $!EbsOptimized,
      @!ElasticGpuSpecification,
      @!ElasticInferenceAccelerator,
      $!EnclaveOptions,
      $!HibernationOptions,
      $!IamInstanceProfile,
      $!ImageId,
      $!InstanceInitiatedShutdownBehavior,
      $!InstanceMarketOptions,
      $!InstanceType,
      @!Ipv6Address,
      $!Ipv6AddressCount,
      $!KernelId,
      $!KeyName,
      $!LaunchTemplate,
      @!LicenseSpecification,
      $!MaxCount,
      $!MetadataOptions,
      $!MinCount,
      $!Monitoring,
      @!NetworkInterface,
      $!Placement,
      $!PrivateIpAddress,
      $!RamdiskId,
      @!SecurityGroup,
      @!SecurityGroupId,
      $!SubnetId,
      @!TagSpecification,
      $!UserData
    -> $_ is raw {
      next unless $_;
      my (\s, \v) = ( .VAR.name.substr(0, 1), .VAR.name.substr(2) );
      if s eq '$' {
        my $cnt = 1;
        if $_ ~~ Amazon::AWS::EC2::Types::Base {
          for .pairs {
            my $pn =  v eq <LaunchTemplate>.any ?? "{ v }.{ .key }"
                                                !! "{ v }.{ $cnt }.{ .key }";
            @args.push: Pair.new($pn, .value);
          }
          $cnt++;
        } else {
          @args.push: Pair.new(v, $_) if $_
        }
      } else {
        say v;
        my @a := ::("\@{ v }Args");
        @args.append: |@a if @a;
      }
    }

    @args.push: Pair.new('Version', '2016-11-15');

    # XXX - Add error handling to makeRequest!
    my $xml = makeRequest(
      "?Action={ $c }&{ @args.map({ "{.key}={.value}" }).join('&') }"
    );

    $raw ??
      $xml
      !!
      ::("Amazon::AWS::EC2::Response::{ $c }Response").from-xml($xml);
  }

}
