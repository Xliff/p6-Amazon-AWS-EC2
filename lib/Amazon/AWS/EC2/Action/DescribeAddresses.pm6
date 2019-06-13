use v6.c;

use XML::Class;
use Method::Also;

use Amazon::AWS::EC2::Filters::DescribeAddressesFilter;
use Amazon::AWS::EC2::Response::DescribeAddressesResponse;
use Amazon::AWS::Utils;

class Amazon::AWS::EC2::Action::DescribeAddresses is export
  does XML::Class[
    xml-element   => 'DescribeAddresses',
    xml-namespace => 'http://ec2.amazonaws.com/doc/2016-11-15/'
  ]
{
  also does Amazon::AWS::Roles::Eqv;

  my $c = ::?CLASS.^name.split('::')[* - 1];

  has Str                      @.allocationIds is xml-container('allocationIdSet') is xml-element('allocationId') is rw;
  has DescribeAddressesFilter  @.filters       is xml-container('filterSet')       is xml-element                 is rw;
  has Bool                     $.DryRun                                            is xml-element                 is rw;
  has Str                      @.publicIps     is xml-container('publicIpSet')     is xml-element('publicIp')     is rw;

  # How to handle use of nextToken? -- TBD
  # Ways to handle: - Max number of requests
  #                 - All in one (no user control)
  #                 - One page (and then pass the next token).

  submethod BUILD (
    :$!DryRun         = False,
    :@allocationIds,
    :@filters,
    :@publicIps
  ) {
    die '@allocationIds must only contain strings'
     unless @allocationIds.all ~~ Str;
    @!allocationIds = @allocationIds;

    @!filters = do given @filters {
      when .all ~~ DescribeAddressesFilter { @!filters }

      default {
        die qq:to/DIE/.chomp;
        Invalid value passed to \@filers. Should only contain DescribeTagsFilter objects, but contains:
        { @filters.map( *.^name ).unique.join('. ') }
        DIE

      }
    };

    die '@publicIps must only contain strings' unless @publicIps.all ~~ Str;
    @!publicIps = @publicIps;
  }

  method run (:$raw)
    is also<
      do
      execute
    >
  {
    my @AllocationIdArgs;
    my $cnt = 1;
    for @!allocationIds {
      @AllocationIdArgs.push: Pair.new("AllocationId.{$cnt++}.{.key}", .value)
        for .pairs;
    }

    my @FilterArgs;
    $cnt = 1;
    for @!filters {
      @FilterArgs.push: Pair.new("Filter.{$cnt++}.{.key}", .value) for .pairs;
    }

    my @PublicIpArgs;
    $cnt = 1;
    for @!publicIps {
      @PublicIpArgs.push: Pair.new("PublicIps.{$cnt++}.{.key}", .value)
        for .pairs;
    }

    # Should already be sorted.
    my @args = (
      |@AllocationIdArgs,
      DryRun         => $.DryRun,
      |@FilterArgs,
      |@PublicIpArgs,
      Version        => '2016-11-15'
    );

    # XXX - Add error handling to makeRequest!
    my $xml = makeRequest(
      "?Action={ $c }&{ @args.map({ "{.key}={.value}" }).join('&') }"
    );

    $raw ??
      $xml
      !!
      Amazon::AWS::EC2::Response::DescribeAddressesResponse.from-xml($xml);
  }

}
