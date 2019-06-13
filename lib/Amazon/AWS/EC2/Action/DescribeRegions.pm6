use v6.c;

use Method::Also;
use XML::Class;

use Amazon::AWS::EC2::Filters::DescribeRegionsFilter;
use Amazon::AWS::EC2::Response::DescribeRegionsResponse;
use Amazon::AWS::EC2::Types::Instance;
use Amazon::AWS::Utils;

class Amazon::AWS::EC2::Action::DescribeRegions is export
  does XML::Class[xml-element => 'DescribeRegions']
{
  my $c = ::?CLASS.^name.split('::')[* - 1];

  has Bool                  $.DryRun                                         is xml-element               is rw;
  has DescribeRegionsFilter @.filters     is xml-container('filterSet')                                   is rw;
  has Str                   @.regions     is xml-container('regionNameSet')  is xml-element('region')     is rw;

  submethod BUILD (
    :$!DryRun = False,
    :@Filters,
    :@Regions
  ) {
    @!filters = do given @Filters {
      when .all ~~ DescribeRegionsFilter { @Filters }

      default {
        die qq:to/DIE/.chomp;
Invalid value passed to \@Filters. Should only contain DescribeRegionFilter objects, but contains:
{ @Filters.grep( * !~~ DescribeRegionsFilter).map( *.^name ).unique.join(', ') }
DIE

      }
    }

    # This can be expanded top anything that returns a regionId
    die qq:to/DIE/.chomp unless @Regions.all ~~ Str;
Invalid value passed to @Regions. Should only contain region name strings, but contains:
{ @Regions.grep( * !~~ Str ).map( *.^name ).unique.join(', ') }
DIE

    @!regions = @Regions;
  }

  method run (:$raw = False)
    is also<
      do
      execute
    >
  {
    # Needs more thought!
    my $cnt = 1;
    my @FilterArgs;
    for @.filters {
      @FilterArgs.push: Pair.new("Filter.{$cnt++}.{.key}", .value) for .pairs;
    }

    $cnt = 1;
    my @RegionArgs;
    @RegionArgs.push: Pair.new("RegionName.{$cnt++}", $_) for @.regions;
    @RegionArgs.say;

    # Should already be sorted.
    my @args = (
      DryRun         => $.DryRun,
      |@FilterArgs,
      |@RegionArgs,
      Version        => '2016-11-15'
    );

    # XXX - Add error handling to makeRequest!
    my $xml = makeRequest(
      "?Action=DescribeRegions&{ @args.map({ "{.key}={.value}" }).join('&') }"
    );

    $raw ??
      $xml
      !!
      Amazon::AWS::EC2::Response::DescribeRegionsResponse.from-xml($xml);
  }

}
