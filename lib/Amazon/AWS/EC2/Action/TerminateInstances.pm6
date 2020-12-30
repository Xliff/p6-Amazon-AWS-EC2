use v6.d;

use Method::Also;
use XML::Class;

use Amazon::AWS::Utils;
use Amazon::AWS::Roles::Eqv;

use Amazon::AWS::EC2::Response::TerminateInstancesResponse;

use Amazon::AWS::EC2::Types::Instance;

class Amazon::AWS::EC2::Types::TerminateInstances is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  my $c = ::?CLASS.^shortname;

  has Bool    $.DryRun          is xml-element                      is xml-skip-null                                     is rw;
  has Str     @.InstanceIds     is xml-element('item', :over-ride)  is xml-skip-null  is xml-container('instanceIdSet')  is rw;

  submethod BUILD (
    :$dryRun,
    :@instances,
    # For deserialization purposes, ONLY!
    :$!DryRun      = False,
    :@!InstanceIds
  ) {
    $!DryRun    = $dryRun    if $dryRun;

    if @instances {
      my @valid-types = (Str, Instance);
      @!InstanceIds = @instances.map({
        do {
          when  Instance { .instanceId.trim }
          when  Str      { .trim            }

          default {
            die qq:to/DIE/.chomp;
              Invalid value passed to \@instances. Should only contain {''
              }Instance-compatible values, but contains:
              { @instances.grep( *.WHAT !~~ @valid-types.any )
                          .map( *.^name ).unique
                          .join(', ') }
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
    my @args = (
      DryRun         => $!DryRun,
      |@InstanceArgs,
      Version        => '2016-11-15'
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
