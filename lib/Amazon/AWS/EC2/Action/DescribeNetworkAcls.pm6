use v6.d;

use XML::Class;
use Method::Also;

use Amazon::AWS::Utils;
use Amazon::AWS::Roles::Eqv;

use Amazon::AWS::EC2::Filters::DescribeNetworkAclsFilter;
use Amazon::AWS::EC2::Response::DescribeNetworkAclsResponse;

class Amazon::AWS::EC2::Action::DescribeNetworkAcls is export
  does XML::Class[
    xml-element   => 'DescribeNetworkAcls',
    xml-namespace => 'http://ec2.amazonaws.com/doc/2016-11-15/'
  ]
{
  also does Amazon::AWS::Roles::Eqv;

  my $c = ::?CLASS.^name.split('::')[* - 1];

  has DescribeNetworkAclsFilter  @.Filters     is xml-container('filterSet')  is xml-element                                is rw;
  has Bool                       $.DryRun                                                             is xml-element         is rw;
  has Str                        @.VpcIds      is xml-container('vpcIdSet')   is xml-element('item')                         is rw;
  has Int                        $.MaxResults                                                         is xml-element         is rw;

  # How to handle use of nextToken? -- TBD
  # Ways to handle: - Max number of requests
  #                 - All in one (no user control)
  #                 - One page (and then pass the next token).

  submethod BUILD (
    :@filters,
    :$dryRun,
    :@vpcIds,
    :$maxResults,
    # For testing purposes only
    :@!Filters,
    :$!DryRun               = False,
    :@!VpcIds,
    :$!MaxResults           = 1000
  ) {
    $!DryRun     = $dryRun     if $dryRun;

    die '$maxResutlts must be an integer between 5 and 1000'
      unless $!MaxResults ~~ 5..1000;

    if @vpcIds {
      @!VpcIds = @vpcIds.map({
        do {
          when Str      { $_          }

          default {
            die qq:to/DIE/.chomp;
            Invalid value passed to \@vpcIds. Should only contain Str objects, but also contains:
            { @vpcIds.grep( * !~~ Str ).map( *.^name ).unique.join(', ') }
            DIE

          }
        }
      }).flat;
    }

    if @filters {
      @!Filters = do given @filters {
        when .all ~~ Amazon::AWS::EC2::Filters::DescribeNetworkAclsFilter { @filters }

        default {
          die qq:to/DIE/.chomp;
          Invalid value passed to \@filers. Should only contain DescribeNetworkAclFilter objects, but contains:
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
    # cw: Not mentioned at https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_DescribeNetworkAcls.html like others,
    # but left in case it was an oversight.
    #
    # die 'Cannot use @.NetworkAclIds and $.maxResults in the same call to DescribeNetworkAcls'
    #   if $.MaxResults.defined && @.NetworkAclIds;

    my $cnt = 1;
    my @VpcIdArgs;
    @VpcIdArgs.push: Pair.new("VpcId.{$cnt++}", $_) for @!VpcIds;

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
        Version        => '2016-11-15',
        |@VpcIdArgs
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
