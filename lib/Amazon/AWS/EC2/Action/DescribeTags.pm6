use v6.c;

use XML::Class;
use Method::Also;

use Amazon::AWS::EC2::Filters::DescribeTagsFilter;
use Amazon::AWS::EC2::Response::DescribeTagsResponse;
use Amazon::AWS::Utils;

class Amazon::AWS::EC2::Action::DescribeTags is export
  does XML::Class[
    xml-element   => 'DescribeTags',
    xml-namespace => 'http://ec2.amazonaws.com/doc/2016-11-15/'
  ]
{
  also does Amazon::AWS::Roles::Eqv;

  my $c = ::?CLASS.^name.split('::')[* - 1];

  has Bool                $.DryRun                                        is xml-element    is rw;
  has DescribeTagsFilter  @.filters     is xml-container('filterSet')     is xml-element    is rw;
  has Int                 $.maxResults                                    is xml-element    is rw;
  has Str                 $.nextToken                                     is xml-element    is rw;

  # How to handle use of nextToken? -- TBD
  # Ways to handle: - Max number of requests
  #                 - All in one (no user control)
  #                 - One page (and then pass the next token).

  submethod BUILD (
    :$!DryRun     = False,
    :$!maxResults = 1000,
    :$!nextToken  = '',
    :@filters,
  ) {
    @filters = do given @!filters {
      when .all ~~ Amazon::AWS::EC2::Filters::DescribeTagsFilter { @!filters }

      default {
        die qq:to/DIE/.chomp;
        Invalid value passed to \@filers. Should only contain DescribeTagsFilter objects, but contains:
        { @filters.map( *.^name ).unique.join('. ') }
        DIE

      }
    };

  }

  method run (:$nextToken = '', :$raw)
    is also<
      do
      execute
    >
  {
    my @FilterArgs;
    my $cnt = 1;
    for @!filters {
      @FilterArgs.push: Pair.new("Filter.{$cnt++}.{.key}", .value) for .pairs;
    }

    # Should already be sorted.
    my @args;

    if $nextToken.chars {
      @args = ( nextToken => $nextToken );
    } else {
      @args = (
        DryRun         => $.DryRun,
        |@FilterArgs,
        MaxResults     => $.maxResults,
        Version        => '2016-11-15'
      );
    }

    # XXX - Add error handling to makeRequest!
    my $xml = makeRequest(
      "?Action={ $c }&{ @args.map({ "{.key}={.value}" }).join('&') }"
    );

    $raw ??
      $xml
      !!
      Amazon::AWS::EC2::Response::DescribeTagsResponse.from-xml($xml);
  }

}
