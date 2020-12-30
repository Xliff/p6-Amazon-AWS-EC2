use v6.d;

use Method::Also;

use Amazon::AWS::Utils;
use Amazon::AWS::Roles::Eqv;

use XML::Class;

use Amazon::AWS::EC2::Filters::DescribeInstanceCreditSpecificationsFilter;
use Amazon::AWS::EC2::Response::DescribeInstanceCreditSpecificationsResponse;

use Amazon::AWS::EC2::Types::Instance;
use Amazon::AWS::EC2::Types::Volume;

class Amazon::AWS::EC2::Action::DescribeInstanceCreditSpecifications is export
  does XML::Class[xml-element => 'item']
{
  also does Amazon::AWS::Roles::Eqv;

  my $c = ::?CLASS.^shortname;

  has Bool                                          $.DryRun         is xml-element                        is xml-skip-null                                           is rw;
  has DescribeInstanceCreditSpecificationsFilter    @.Filters        is xml-element('item', :over-ride)    is xml-skip-null    is xml-container('filterSet')          is rw;
  has Str                                           @.InstanceIds    is xml-element('item', :over-ride)    is xml-skip-null    is xml-container('instanceIdSet')      is rw;
  has Int                                           $.MaxResults     is xml-element                        is xml-skip-null                                           is rw;
  has Str                                           $.NextToken      is xml-element                        is xml-skip-null                                           is rw;

  submethod BUILD (
    :$dryRun,
    :@filters,
    :@instances,
    :$maxResults,
    # For testing purposes ONLY!
    :$!DryRun       = False,
    :@!Filters,
    :@!InstanceIds,
    :$!MaxResults   = 1000
  ) {
    $!DryRun     = $dryRun     if $dryRun;
    $!MaxResults = $maxResults if $maxResults;

    if @instances {
      @!InstanceIds = @instances.map({
        do {
          when Str      { $_          }
          when Instance { .instanceID }
          when Volume   { .attachments.map( *.instanceId ) }

          default {
            die qq:to/DIE/.chomp;
            Invalid value passed to \@instances. Should only contain Instance objects, but contains:
            { @instances.map( *.^name ).unique.join(', ') }
            DIE

          }
        }
      }).flat;
    }

    if @filters {
      @!Filters = do given @filters {
        when .all ~~ DescribeInstanceCreditSpecificationsFilter    { @filters }

        default {
          die qq:to/DIE/.chomp;
  Invalid value passed to \@Filters. Should only contain DescribeInstanceCreditSpecificationsFilter objects, but contains:
  { @filters.grep( * !~~ DescribeInstanceCreditSpecificationsFilter).map( *.^name ).unique.join(', ') }
  DIE

        }
      }
    }
  }

  method run (:$raw)
    is also<
      do
      execute
    >
  {
    my $cnt = 1;
    my @InstanceArgs;
    @InstanceArgs.push: Pair.new("InstanceId.{$cnt++}", $_) for @!InstanceIds;

    my @FilterArgs;
    $cnt = 1;
    for @!Filters {
      @FilterArgs.push: Pair.new("Filter.{$cnt}.{.key}", urlEncode(.value))
        for .pairs;
      $cnt++;
    }

    # Should already be sorted.
    my @args = (
      DryRun     => $!DryRun,
      |@FilterArgs,
      |@InstanceArgs,
      Version    => '2016-11-15'
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
