use v6.d;

use XML::Class;
use Method::Also;

use Amazon::AWS::Utils;
use Amazon::AWS::Roles::Eqv;

use Amazon::AWS::EC2::Filters::DescribeImportImageTasksFilter;
use Amazon::AWS::EC2::Response::DescribeImportImageTasksResponse;

class Amazon::AWS::EC2::Action::DescribeImportImageTasks is export
  does XML::Class[
    xml-element   => 'DescribeImportImageTasks',
    xml-namespace => 'http://ec2.amazonaws.com/doc/2016-11-15/'
  ]
{
  also does Amazon::AWS::Roles::Eqv;

  my $c = ::?CLASS.^shortname;

  has Bool                              $.DryRun           is xml-element                        is xml-skip-null                                              is rw;
  has DescribeImportImageTasksFilter    @.Filters          is xml-element('item', :over-ride)    is xml-skip-null    is xml-container('filterSet')             is rw;
  has Str                               @.ImportTaskIds    is xml-element('item', :over-ride)    is xml-skip-null    is xml-container('importTaskIdsSet')      is rw;
  has Int                               $.MaxResults       is xml-element                        is xml-skip-null                                              is rw;
  has Str                               $.NextToken        is xml-element                        is xml-skip-null                                              is rw;

  submethod BUILD (
    :$dryRun,
    :@filters,
    :@importTasks,
    :$maxResults,
    :$nextToken,
    # For testing purposes, ONLY!
    :$!DryRun         = False,
    :@!Filters,
    :@!ImportTaskIds,
    :$!MaxResults     = 500,
    :$!NextToken      = ''
  ) {
    $!DryRun     = $dryRun     if $dryRun;
    $!MaxResults = $maxResults if $maxResults;

    if @importTasks {
      @!ImportTaskIds = @importTasks.map({
        if .?Str -> $s {
          $_ = $s;
        }
        do {
          when Str      { $_          }

          default {
            die qq:to/DIE/.chomp;
            Invalid value passed to \@instanceTasks. Should only contain Str objects, but contains:
            { @importTasks.map( *.^name ).grep( * ne 'Str').unique.join(', ') }
            DIE
          }
        }
      }).flat;
    }

    if @filters {
      @!Filters = do given @filters {
        when .all ~~ Amazon::AWS::EC2::Filters::DescribeImportImageTasksFilter
          { @filters }

        default {
          die qq:to/DIE/.chomp;
          Invalid value passed to \@filers. Should only contain DescribeImportImageTasksFilter objects, but also contains:
          { @filters.grep( * !~~ DescribeImportImageTasksFilter )
                    .map( *.^name ).grep( * ne 'DescribeImportImageTasksFilter').unique.join('. ') }
          DIE

        }
      };
    }
  }

  method run (:$nextToken = '', :$raw)
    is also<
      do
      execute
    >
  {
    my $cnt = 1;
    my @ImportTaskIdArgs;
    @ImportTaskIdArgs.push: Pair.new("ImportTaskId.{$cnt++}", $_) for @!ImportTaskIds;

    my @FilterArgs;
    $cnt = 1;
    for @!Filters {
      @FilterArgs.push: Pair.new("Filter.{$cnt++}.{.key}", urlEncode(.value))
        for .pairs;
    }

    # Should already be sorted.
    my @args;

    if $nextToken.chars {
      @args = ( nextToken => $nextToken );
    } else {
      # Should already be sorted.
      @args = (
        DryRun     => $!DryRun,
        |@FilterArgs,
        |@ImportTaskIdArgs,
        Version    => '2016-11-15'
      );
    }

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
