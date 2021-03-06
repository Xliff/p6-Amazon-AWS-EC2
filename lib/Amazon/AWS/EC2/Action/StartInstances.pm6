use v6.d;

use Method::Also;
use XML::Class;

use Amazon::AWS::EC2::Types::Instance;

use Amazon::AWS::Utils;
use Amazon::AWS::Roles::Eqv;

use Amazon::AWS::EC2::Response::StartInstancesResponse;

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
    :@instance-ids,
    # For deserialization purposes only
    :$!AdditionalInfo = '',
    :$!DryRun         = False,
    :@!InstanceIds
  ) {
    my $ai = ($additionalInfo // '').trim;

    $!AdditionalInfo = $ai     if $ai.chars;
    $!DryRun         = $dryRun if $dryRun;

    if @instance-ids {
      @!InstanceIds = @instance-ids.map({
        do {
          when Str       { .trim }
          when Instance  { .instanceId.trim }

          default {
            die qq:to/DIE/.chomp;
      Invalid value passed to \@instances. Should only contain {''
      }Instance-compatible values, but contains:
      { @instance-ids.map( *.^name ).unique.join(', ') }
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
    @InstanceArgs.push: Pair.new("InstanceId.{$cnt++}", $_) for @!InstanceIds;

    # Should already be sorted.
    my @args;
    @args.push: (AdditionalInfo => $!AdditionalInfo)
      if $!AdditionalInfo.chars;
    @args.append: (
      DryRun  => $!DryRun,
      |@InstanceArgs,
      Version => '2016-11-15'
    );

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
