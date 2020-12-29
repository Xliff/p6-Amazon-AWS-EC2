use v6.d;

use XML::Class;
use Method::Also;

use Amazon::AWS::Utils;
use Amazon::AWS::Roles::Eqv;

use Amazon::AWS::EC2::Filters::DescribeRouteTablesFilter;
use Amazon::AWS::EC2::Response::DescribeRouteTablesResponse;

class Amazon::AWS::EC2::Action::DescribeRouteTables is export
  does XML::Class[
    xml-element   => 'DescribeRouteTables',
    xml-namespace => 'http://ec2.amazonaws.com/doc/2016-11-15/'
  ]
{
  also does Amazon::AWS::Roles::Eqv;

  my $c = ::?CLASS.^name.split('::')[* - 1];

  has DescribeRouteTablesFilter  @.Filters        is xml-container('filterSet')         is xml-element          is rw;
  has Bool                       $.DryRun                                               is xml-element          is rw;
  has Str                        @.RouteTableIds  is xml-container('RouteTableIdset')   is xml-element('item')  is rw;
  has Int                        $.MaxResults                                           is xml-element          is rw;

  # How to handle use of nextToken? -- TBD
  # Ways to handle: - Max number of requests
  #                 - All in one (no user control)
  #                 - One page (and then pass the next token).

  submethod BUILD (
    :@filters,
    :$dryRun,
    :@routeTableIds,
    :$maxResults,
    # For testing purposes only
    :@!Filters,
    :$!DryRun               = False,
    :@!RouteTableIds,
    :$!MaxResults           = 100
  ) {
    die '$maxResutlts must be an integer between 5 and 100'
      unless $!MaxResults ~~ 5..100;

    if @routeTableIds {
      @!RouteTableIds = @routeTableIds.map({
        do {
          when Str      { $_          }

          default {
            die qq:to/DIE/.chomp;
            Invalid value passed to \@RouteTableIds. Should only contain Str objects, but also contains:
            { @routeTableIds.grep( * !~~ Str ).map( *.^name ).unique.join(', ') }
            DIE

          }
        }
      }).flat;
    }

    if @filters {
      @!Filters = do given @filters {
        when .all ~~ Amazon::AWS::EC2::Filters::DescribeRouteTablesFilter { @filters }

        default {
          die qq:to/DIE/.chomp;
          Invalid value passed to \@filers. Should only contain DescribeRouteTablesFilter objects, but contains:
          { @filters.map( *.^name ).unique.join('. ') }
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
    # cw: Not mentioned at https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_DescribeRouteTables.html like others,
    # but left in case it was an oversight.
    #
    # die 'Cannot use @.RouteTableIds and $.maxResults in the same call to DescribeRouteTables'
    #   if $.MaxResults.defined && @.RouteTableIds;

    my $cnt = 1;
    my @RouteTableArgs;
    @RouteTableArgs.push: Pair.new("RouteTableId.{$cnt++}", $_)
      for @!RouteTableIds;

    my @FilterArgs;
    $cnt = 1;
    for @!Filters {
      @FilterArgs.push: Pair.new("Filter.{$cnt}.{.key}", urlEncode(.value))
        for .pairs;
      $cnt++;
    }

    # Should already be sorted.
    my @args;

    if $nextToken.chars {
      @args = ( nextToken => $nextToken );
    } else {
      @args = (
        DryRun         => $!DryRun,
        |@FilterArgs,
        MaxResults     => $!MaxResults,
        |@RouteTableArgs,
        Version        => '2016-11-15',
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
