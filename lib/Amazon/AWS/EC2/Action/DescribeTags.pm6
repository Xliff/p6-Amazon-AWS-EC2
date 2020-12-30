use v6.d;

use XML::Class;
use Method::Also;

use Amazon::AWS::Utils;
use Amazon::AWS::Roles::Eqv;

use Amazon::AWS::EC2::Filters::DescribeTagsFilter;
use Amazon::AWS::EC2::Response::DescribeTagsResponse;

class Amazon::AWS::EC2::Action::DescribeTags is export
  does XML::Class[
    xml-element   => 'DescribeTags',
    xml-namespace => 'http://ec2.amazonaws.com/doc/2016-11-15/'
  ]
{
  also does Amazon::AWS::Roles::Eqv;

  my $c = ::?CLASS.^name.split('::')[* - 1];

  has Bool                $.DryRun                                        is xml-element    is rw;
  has DescribeTagsFilter  @.Filters     is xml-container('filterSet')                       is rw;
  has Int                 $.MaxResults                                    is xml-element    is rw;
  #has Str                 $.NextToken                                     is xml-element    is rw;

  # How to handle use of nextToken? -- TBD
  # Ways to handle: - Max number of requests
  #                 - All in one (no user control)
  #                 - One page (and then pass the next token).

  submethod BUILD (
    :$dryRun,
    :@filters,
    :$maxResults,
    :$!DryRun     = False,
    :@!Filters,
    :$!MaxResults = 1000,
    #:$!nextToken  = '',
  ) {
    $!DryRun = $dryRun if $dryRun;
    if $maxResults.defined {
      die ':$maxResults must be a number from 5 to 1000'
        unless $maxResults ~~ 5..1000;
      $!MaxResults = $maxResults;
    }

    if @filters {
      @!Filters = do given @filters {
        when .all ~~ DescribeTagsFilter    { @filters }

        default {
          die qq:to/DIE/.chomp;
          Invalid value passed to \@filers. Should only contain DescribeTagsFilter objects, but contains:
          { @filters.map( *.^name ).unique.join('. ') }
          DIE

        }
      };
    }
  }


  method run (Str :$nextToken is copy, :$raw)
    is also<
      do
      execute
    >
  {
    # Prevent reassignment to an undefined valie.
    $nextToken //= '';

    my @FilterArgs;
    my $cnt = 1;
    for @!Filters {
      @FilterArgs.push: Pair.new("Filter.{$cnt}.{.key}", urlEncode(.value))
        for .pairs;
      $cnt++;
    }

    # Should already be sorted.
    my @args;

    if (my $nt = $nextToken.trim).chars {
      @args = ( nextToken => $nt );
    } else {
      @args = (
        DryRun         => $!DryRun,
        |@FilterArgs,
        MaxResults     => $!MaxResults,
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
      ::("Amazon::AWS::EC2::Response::{ $c }Response").from-xml($xml);
  }

}
