use v6.d;

use Method::Also;

use Amazon::AWS::Utils;
use Amazon::AWS::Roles::Eqv;

use XML::Class;

use Amazon::AWS::EC2::Filters::DescribeBundleTasksFilter;
use Amazon::AWS::EC2::Response::DescribeBundleTasksResponse;

class Amazon::AWS::EC2::Action::DescribeBundleTasks is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::Roles::Eqv;

  my $c = ::?CLASS.^shortname;

  has Str                          @.BundleIds   is xml-element('item', :over-ride)    is xml-skip-null    is xml-container('bundleTaskIdSet')  is rw;
  has Bool                         $.DryRun      is xml-element                        is xml-skip-null                                         is rw;
  has DescribeBundleTasksFilter    @.Filters     is xml-element('item', :over-ride)    is xml-skip-null    is xml-container('filterSet')        is rw;

  submethod BUILD (
    :$dryRun,
    :@bundleIds,
    :@filters,
    # For deserialization purposes, only!
    :$!DryRun     = False,
    :@!BundleIds,
    :@!Filters
  ) {
    $!DryRun     = $dryRun     if $dryRun;

    if @bundleIds {
      die qq:to/DIE/.chomp unless @bundleIds.all ~~ Str;
    Invalid value passed to \@bundleIds. Should only strings, but contains:
    { @bundleIds.grep( * !~~ Str ).map( *.^name ).unique.join(', ') }
    DIE

      @!BundleIds = @bundleIds;
    }

    if @filters {
      @!Filters = do given @filters {
        when .all ~~ DescribeBundleTasksFilter    { @filters }

        default {
          die qq:to/DIE/.chomp;
  Invalid value passed to \@Filters. Should only contain DescribeBundleTasksFilter objects, but contains:
  { @filters.grep( * !~~ DescribeBundleTasksFilter).map( *.^name ).unique.join(', ') }
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
    my @BundleIdArgs;
    @BundleIdArgs.push: Pair.new("BundleId.{$cnt++}", $_)
      for @!BundleIds;

    $cnt = 1;
    my @FilterArgs;
    for @!Filters {
      @FilterArgs.push: Pair.new("Filter.{$cnt}.{.key}", urlEncode(.value))
        for .pairs;
      $cnt++;
    }

    # Should already be sorted.
    my @args = (
      DryRun     => $!DryRun,
      |@BundleIdArgs,
      |@FilterArgs,
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
