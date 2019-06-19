use v6.c;

use Method::Also;
use XML::Class;

use Amazon::AWS::EC2::Types::Instance;

use Amazon::AWS::EC2::Response::RebootInstancesResponse;
use Amazon::AWS::Utils;
use Amazon::AWS::Roles::Eqv;

class Amazon::AWS::EC2::Action::RebootInstances is export
  does XML::Class[
    xml-element   => 'RebootInstances',
    xml-namespace => 'http://ec2.amazonaws.com/doc/2016-11-15/'
  ]
{
  also does Amazon::AWS::Roles::Eqv;

  my $c = ::?CLASS.^name.split('::')[* - 1];

  has Bool $.DryRun                                         is xml-element                     is rw;
  has Str  @.InstanceIds is xml-container('instancesIdSet') is xml-element('item', :over-ride) is rw;

  submethod BUILD (
    :$dryRun,
    :@instances,
    # For deserialization purposes, ONLY!
    :$!DryRun      = False,
    :@!InstanceIds
  ) {
    $!DryRun    = $dryRun    if $dryRun.defined;
    
    if @instances {
      my @valid-types = (Str, Instance);
      @!InstanceIds = @instances.map({
        do {
          when  Instance { .instanceId }
          when  Str      { $_          }
          
          default {
            die qq:to/DIE/.chomp;
    Invalid value passed to \@instances. Should only contain Instance-ID compatible Strings, but contains:
    { @instances.grep( *.WHAT !~~ @valid-types.any ).map( *.^name ).unique
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
    @InstanceArgs.push: Pair.new("InstanceId.{$cnt++}", $_) for @.InstanceIds;
    @InstanceArgs.say;

    # Should already be sorted.
    my @args = (
      DryRun         => $.DryRun,
      |@InstanceArgs,
      Version        => '2016-11-15'
    );

    # XXX - Add error handling to makeRequest!
    my $xml = makeRequest(
      "?Action={ $c }}&{ @args.map({ "{.key}={.value}" }).join('&') }"
    );

    $raw ??
      $xml
      !!
      ::("Amazon::AWS::EC2::Response::{ $c }").from-xml($xml);
  }

}
