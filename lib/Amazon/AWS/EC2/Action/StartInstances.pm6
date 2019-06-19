use v6.c;

use Method::Also;
use XML::Class;

use Amazon::AWS::EC2::Types::Instance;

use Amazon::AWS::EC2::Response::StartInstancesResponse;
use Amazon::AWS::Utils;

use Amazon::AWS::Roles::Eqv;

class Amazon::AWS::EC2::Action::StartInstances is export
  does XML::Class[
    xml-element   => 'StartInstances',
    xml-namespace => 'http://ec2.amazonaws.com/doc/2016-11-15/'
  ]
{
  also does Amazon::AWS::Roles::Eqv;

  my $c = ::?CLASS.^name.split('::')[* - 1];

  has Str  $.AdditionalInfo                                   is xml-element               is rw;
  has Bool $.DryRun                                           is xml-element               is rw;
  has Str  @.InstanceIds   is xml-container('instancesIdSet') is xml-element('instanceId') is rw;

  submethod BUILD (
    :$additionalInfo,
    :$dryRun,
    :@instances,
    # For deserialization purposes only
    :$!AdditionalInfo = '',
    :$!DryRun         = False,
    :@!InstanceIds
  ) {
    $!AdditionalInfo = $additionalInfo if $additionalInfo.defined;
    $!DryRun         = $dryRun         if $dryRun.defined;
    
    if @instances {
      @!InstanceIds = @instances.map({
        do {
          when Str       { $_ }
          when Instance  { .instanceId }
          
          default {
            die qq:to/DIE/.chomp;
      Invalid value passed to \@instances. Should only contain Instance objects, but contains:
      { @instances.map( *.^name ).unique.join(', ') }
      DIE

          }
        }
      });
    }
  }

  method run (:$raw = False)
    is also<
      do
      execute
    >
  {
    my $cnt = 1;
    my @InstanceArgs;
    @InstanceArgs.push: Pair.new("InstanceId.{$cnt++}", $_) for @.InstanceIds;
    @InstanceArgs.say;

    # Should already be sorted.
    my @args = (
      DryRun         => $.DryRun,
      |@InstanceArgs,
      Version        => '2016-11-15'
    );
    @args.unshift: Pair.new('AdditionalInfo', $.AdditionalInfo)
      if $.AdditionalInfo.chars;

    # XXX - Add error handling to makeRequest!
    my $xml = makeRequest(
      "?Action={ $c }&{ @args.map({ "{.key}={.value}" }).join('&') }"
    );

    $raw ??
      $xml
      !!
      Amazon::AWS::EC2::Response::StartInstancesResponse.from-xml($xml);
  }

}
