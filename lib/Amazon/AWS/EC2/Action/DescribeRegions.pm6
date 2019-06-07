use v6.c;

use Method::Also;
use XML::Class;

use Amazon::AWS::Utils;
use Amazon::AWS::EC2::Instance;
use Amazon::AWS::EC2::Response::DescribeRegions;

class Amazon::AWS::EC2::Action::DescribeRegions::Filter is export
    does XML::Class[xml-element => 'item']
{
    has Str $.endpoint                                       is xml-element                is rw;
    has Str $.region-name                                    is xml-element                is rw;
}

constant Filter := Amazon::AWS::EC2::Action::DescribeRegions::Filter;

class Amazon::AWS::EC2::Action::DescribeRegions is export
  does XML::Class[xml-element => 'DescribeRegions']
{
  has Bool   $.DryRun                                        is xml-element                is rw;
  has Filter @.filters     is xml-container('filterSet')                                   is rw;
  has Str    @.regions     is xml-container('regionNameSet') is xml-element('region')      is rw;

  submethod BUILD (
    :$!DryRun = False,
    :@Filters,
    :@Regions
  ) {
    @!filters = do given @Filters {
      when .all ~~ Filter { @Filters }

      default {
        die qq:to/DIE/.chomp;
Invalid value passed to \@Filters. Should only contain EC2 DescribeRegion Filter objects, but contains:
{ @Filters.grep( * !~~ Filter).map( *.^name ).unique.join(', ') }
DIE

      }
    }

    die qq:to/DIE/.chomp unless @Regions.all ~~ Str;
Invalid value passed to @Regions. Should only contain region name strings, but contains:
{ @Regions.grep( * !~~ Str ).map( *.^name ).unique.join(', ') }
DIE

    @!regions = @Regions;
  }

  method run
    is also<
      do
      execute
    >
  {
    # Needs more thought!
    my $c = 1;
    my @FilterArgs;
    for @.filters {
      @FilterArgs.push: Pair.new("Filter.{$c++}.{.key}", .value) for .pairs;
    }

    $c = 1;
    my @RegionArgs;
    @RegionArgs.push: Pair.new("RegionName.{$c++}", $_) for @.regions;
    @RegionArgs.say;

    # Should already be sorted.
    my @args = (
      DryRun         => $.DryRun,
      |@FilterArgs,
      |@RegionArgs,
      Version        => '2016-11-15'
    );

    # XXX - Add error handling to makeRequest!
    Amazon::AWS::EC2::Response::DescribeRegions.from-xml(
      makeRequest(
        "?Action=DescribeRegions&{ @args.map({ "{.key}={.value}" }).join('&') }"
      )
    );
  }

}
