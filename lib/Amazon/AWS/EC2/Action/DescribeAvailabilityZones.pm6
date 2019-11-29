use v6.c;

use XML::Class;
use Method::Also;

use Amazon::AWS::Utils;
use Amazon::AWS::Roles::Eqv;

use Amazon::AWS::EC2::Filters::DescribeAvailabilityZonesFilter;
use Amazon::AWS::EC2::Response::DescribeAvailabilityZonesResponse;

class Amazon::AWS::EC2::Action::DescribeAvailabilityZones is export
  does XML::Class[
    xml-element   => 'DescribeAvailabilityZones',
    xml-namespace => 'http://ec2.amazonaws.com/doc/2016-11-15/'
  ]
{
  also does Amazon::AWS::Roles::Eqv;

  my $c = ::?CLASS.^name.split('::')[* - 1];

  has Bool                             $.DryRun                                          is xml-element                      is rw;
  has DescribeAvailabilityZonesFilter  @.Filters      is xml-container('filterSet')      is xml-element('item', :over-ride)  is rw;
  has Str                              @.ZoneIds      is xml-container('zoneIdSet')      is xml-element('item', :over-ride)  is rw;
  has Str                              @.ZoneNames    is xml-container('zoneNameSet')    is xml-element('item', :over-ride ) is rw;

  # How to handle use of nextToken? -- TBD
  # Ways to handle: - Max number of requests
  #                 - All in one (no user control)
  #                 - One page (and then pass the next token).

  submethod BUILD (
    :$dryRun,
    :@filters,
    :@zoneIds,
    :@zoneNames,
    # Reserved for testing purposes only!
    :$!DryRun         = False,
    :@!Filters,
    :@!ZoneIds,
    :@!ZoneNames
  ) {
    $!DryRun //= $dryRun // False;

    if @zoneIds {
      die '@allocationIds must only contain strings'
       unless @zoneIds.all ~~ Str;
      @!ZoneIds //= @zoneIds;
    }

    if @filters {
      @!Filters //= do given @filters {
        when .all ~~ DescribeAvailabilityZonesFilter    { @filters }

        default {
          die qq:to/DIE/.chomp;
          Invalid value passed to \@filers. Should only contain DescribeAvailabilityZonesFilter objects, but contains:
          { @filters.map( *.^name ).unique.join('. ') }
          DIE

        }
      };
    }

    if @zoneIds {
      die '@publicIps must only contain strings' unless @zoneIds.all ~~ Str;
      @!ZoneIds //= @zoneIds;
    }

    if @zoneNames {
      die '@publicIps must only contain strings' unless @zoneNames.all ~~ Str;
      @!ZoneNames //= @zoneNames;
    }
  }

  method run (:$raw)
    is also<
      do
      execute
    >
  {
    my @FilterArgs;
    my $cnt = 1;
    for @!Filters {
      @FilterArgs.push: Pair.new("Filter.{$cnt++}.{.key}", .value) for .pairs;
    }

    my @ZoneIdArgs;
    $cnt = 1;
    for @!ZoneIds {
      @ZoneIdArgs.push: Pair.new("ZoneIds.{$cnt++}.{.key}", .value)
        for .pairs;
    }

    my @ZoneNameArgs;
    $cnt = 1;
    for @!ZoneNames {
      @ZoneNameArgs.push: Pair.new("ZoneNames.{$cnt++}.{.key}", .value)
        for .pairs;
    }

    # Should already be sorted.
    my @args = (
      DryRun         => $.DryRun
    );
    for @FilterArgs, @ZoneIdArgs, @ZoneNameArgs {
      @args.append: $_ if .elems
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
