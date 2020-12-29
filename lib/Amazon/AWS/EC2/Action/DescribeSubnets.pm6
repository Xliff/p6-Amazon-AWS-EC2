use v6.d;

use XML::Class;
use Method::Also;

use Amazon::AWS::Utils;
use Amazon::AWS::Roles::Eqv;

use Amazon::AWS::EC2::Filters::DescribeSubnetsFilter;
use Amazon::AWS::EC2::Response::DescribeSubnetsResponse;

class Amazon::AWS::EC2::Action::DescribeSubnets is export
  does XML::Class[
    xml-element   => 'DescribeSubnets',
    xml-namespace => 'http://ec2.amazonaws.com/doc/2016-11-15/'
  ]
{
  also does Amazon::AWS::Roles::Eqv;

  my $c = ::?CLASS.^name.split('::')[* - 1];

  has Bool                   $.DryRun                                        is xml-element                      is xml-skip-null is rw;
  has DescribeSubnetsFilter  @.Filters      is xml-container('filterSet')                                        is xml-skip-null is rw;
  has Int                    $.MaxResults                                    is xml-element                      is xml-skip-null is rw;
  has Str                    @.SubnetIds    is xml-container('subnetIdSet')  is xml-element('item', :over-ride)  is xml-skip-null is rw;

  # How to handle use of nextToken? -- TBD
  # Ways to handle: - Max number of requests
  #                 - All in one (no user control)
  #                 - One page (and then pass the next token).

  submethod BUILD (
    :$dryRun,
    :@filters,
    :$maxResults,
    :@subnetIds,
    # For testing purposes only
    :$!DryRun     = False,
    :@!Filters,
    :$!MaxResults = 1000,
    :@!SubnetIds,
  ) {
    if $maxResults {
      die '$maxResult muet be an integer between 5 and 1000'
        unless $maxResults ~~ 5..1000;
      $!MaxResults = $maxResults;
    }

    # if @filters {
    #   @!Filters = do given @filters {
    #     when .all ~~ Amazon::AWS::EC2::Filters::DescribeSubnetsFilter
    #       { @filters }
    #
    #     default {
    #       die qq:to/DIE/.chomp;
    #       Invalid value passed to \@filers. Should only contain DescribeHostReservationFilter objects, but contains:
    #       { @filters.map( *.^name ).unique.join('. ') }
    #       DIE
    #
    #     }
    #   };
    # }

    if @subnetIds {
      @!SubnetIds = do given @subnetIds {
        when .all ~~ Str    { @subnetIds }

        default {
          die qq:to/DIE/.chomp;
          Invalid value passed to \@filers. Should only contain Str objects, but also contains:
          { @filters.grep( * !~~ Str ).map( *.^name ).unique.join('. ') }
          DIE

        }
      }
    }

  }

  method run (:$nextToken = '', :$raw)
    is also<
      do
      execute
    >
  {
    # Now limitations beyond the valid rage is given at https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_DescribeSubnets.html
    # Code left here in case there was an omission.
    # die 'Cannot use @.HostReservation and $.maxResults in the same call to DescribeHostReservation'
    #   if $.MaxResults.defined && @.OfferingId;

    my @FilterArgs;
    my $cnt = 1;
    for @!Filters {
      @FilterArgs.push: Pair.new("Filter.{$cnt}.{.key}", urlEncode(.value))
        for .pairs;
      $cnt++;
    }

    my @SubnetIdArgs;
    $cnt = 1;
    @SubnetIdArgs.push: Pair.new("SubnetId.{$cnt++}", $_) for @!SubnetIds;

    # Should already be sorted.
    my @args;

    if (my $nt = $nextToken.trim).chars {
      @args = ( nextToken => $nt );
    } else {
      @args = (
        DryRun         => $!DryRun,
        |@FilterArgs,
        MaxResults     => $!MaxResults,
        |@SubnetIdArgs,
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
