use v6.c;

use Method::Also;
use XML::Class;

use Amazon::AWS::EC2::Filters::DescribeElasticGpusFilter;
use Amazon::AWS::EC2::Response::DescribeElasticGpusResponse;
use Amazon::AWS::EC2::Types::Instance;

use Amazon::AWS::Utils;
use Amazon::AWS::Roles::Eqv;

class Amazon::AWS::EC2::Action::DescribeElasticGpus is export
  does XML::Class[xml-element => 'DescribeElasticGpus']
{
  also does Amazon::AWS::Roles::Eqv;

  my $c = ::?CLASS.^name.split('::')[* - 1];

  has Bool                      $.DryRun                                              is xml-element                         is rw;
  has DescribeElasticGpusFilter @.Filters        is xml-container('filterSet')                                               is rw;
  has Str                       @.ElasticGpuIds  is xml-container('elasticGpuIdSet')  is xml-element('item', :over-ride)     is rw;

  submethod BUILD (
    :$dryRun,
    :@filters,
    :@elasticGpuIds,
    # Testing purposes only!
    :$!DryRun = False,
    :@!Filters,
    :@!ElasticGpuIds
  ) {
    if @filters {
      @!Filters = do given @filters {
        when .all ~~ DescribeElasticGpusFilter    { @filters }

        default {
          die qq:to/DIE/.chomp;
  Invalid value passed to \@Filters. Should only contain DescribeElasticGpu objects, but contains:
  { @filters.grep( * !~~ DescribeElasticGpusFilter).map( *.^name ).unique.join(', ') }
  DIE

        }
      }
    }

    # This can be expanded top anything that returns a regionId
    if @elasticGpuIds {
      die qq:to/DIE/.chomp unless @elasticGpuIds.all ~~ Str;
  Invalid value passed to \@elasticGpuIds. Should only strings, but contains:
  { @elasticGpuIds.grep( * !~~ Str ).map( *.^name ).unique.join(', ') }
  DIE

      @!ElasticGpuIds = @elasticGpuIds;
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
    my @ElasticGpuIdArgs;
    @ElasticGpuIdArgs.push: Pair.new("ElasticGpuId.{$cnt++}", $_) for @.ElasticGpuIds;

    # Should already be sorted.
    my @args = (
      DryRun         => $.DryRun,
      |@ElasticGpuIdArgs,
      |@FilterArgs,
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
