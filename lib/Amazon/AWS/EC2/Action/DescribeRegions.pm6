use v6.c;

use Method::Also;
use XML::Class;

use Amazon::AWS::EC2::Filters::DescribeRegionsFilter;
use Amazon::AWS::EC2::Response::DescribeRegionsResponse;

use Amazon::AWS::Utils;

use Amazon::AWS::Roles::Eqv;

class Amazon::AWS::EC2::Action::DescribeRegions is export
  does XML::Class
{
  also does Amazon::AWS::Roles::Eqv;

  my $c = ::?CLASS.^name.split('::')[* - 1];

  has Bool                  $.DryRun                                         is xml-element                      is rw;
  has DescribeRegionsFilter @.Filters     is xml-container('filterSet')      is xml-element('item', :over-ride)  is rw;
  has Str                   @.Regions     is xml-container('regionNameSet')  is xml-element('item')              is rw;

  submethod BUILD (
    :$dryRun;
    :@filters,
    :@regions,
    # For testing purposes, only!
    :$!DryRun = False,
    :@!Filters,
    :@!Regions
  ) {
    $!DryRun = $dryRun if $dryRun.defined;
    
    if @filters {
      @!Filters = do given @filters {
        when .all ~~ DescribeRegionsFilter    { @filters }

        default {
          die qq:to/DIE/.chomp;
  Invalid value passed to \@filters. Should only contain DescribeRegionFilter objects, but contains:
  { @filters.grep( * !~~ DescribeRegionsFilter).map( *.^name ).unique.join(', ') }
  DIE

        }
      }
    }

    if @regions {
      # This can be expanded top anything that returns a regionId
      die qq:to/DIE/.chomp unless @regions.all ~~ Str;
  Invalid value passed to \@regions. Should only contain region name strings, but contains:
  { @regions.grep( * !~~ Str ).map( *.^name ).unique.join(', ') }
  DIE

      @!Regions = @regions;
    }
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
    for @.Filters {
      @FilterArgs.push: Pair.new("Filter.{$cnt++}.{.key}", .value) for .pairs;
    }

    $cnt = 1;
    my @RegionArgs;
    @RegionArgs.push: Pair.new("RegionName.{$cnt++}", $_) for @.Regions;
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
