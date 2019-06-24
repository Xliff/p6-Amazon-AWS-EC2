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

  has Str                      @.AllocationIds is xml-container('allocationIdSet') is xml-element('allocationId')      is xml-skip-null is rw;
  has DescribeAddressesFilter  @.Filters       is xml-container('filterSet')       is xml-element('item', :over-ride)  is xml-skip-null is rw;
  has Bool                     $.DryRun                                            is xml-element                      is xml-skip-null is rw;
  has Str                      @.PublicIps     is xml-container('publicIpSet')     is xml-element('publicIp')          is xml-skip-null is rw;

  # How to handle use of nextToken? -- TBD
  # Ways to handle: - Max number of requests
  #                 - All in one (no user control)
  #                 - One page (and then pass the next token).

  submethod BUILD (
    :$dryRun,
    :@allocationIds,
    :@filters,
    :@publicIps,
    # Reserved for testing purposes only!
    :$!DryRun         = False,
    :@!AllocationIds,
    :@!Filters,
    :@!PublicIps
  ) {
    $!DryRun //= $dryRun // False;
    
    if @allocationIds {
      die '@allocationIds must only contain strings'
       unless @allocationIds.all ~~ Str;
      @!AllocationIds //= @allocationIds
    }

    if @filters {
      @!Filters //= do given @filters {
        when .all ~~ DescribeAddressesFilter      { @filters }

        default {
          die qq:to/DIE/.chomp;
          Invalid value passed to \@filers. Should only contain DescribeTagsFilter objects, but contains:
          { @filters.map( *.^name ).unique.join('. ') }
          DIE

        }
      };
    }

    if @publicIps {
      die '@publicIps must only contain strings' unless @publicIps.all ~~ Str;
      @!PublicIps //= @publicIps;
    }
  }

  method run (:$raw)
    is also<
      do
      execute
    >
  {
    my @AllocationIdArgs;
    my $cnt = 1;
    for @!AllocationIds {
      @AllocationIdArgs.push: Pair.new("AllocationId.{$cnt++}.{.key}", .value)
        for .pairs;
    }

    my @FilterArgs;
    $cnt = 1;
    for @!Filters {
      @FilterArgs.push: Pair.new("Filter.{$cnt++}.{.key}", .value) for .pairs;
    }

    my @PublicIpArgs;
    $cnt = 1;
    for @!PublicIps {
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
      ::("Amazon::AWS::EC2::Response::{ $c }Response").from-xml($xml);
  }

}
