use v6.c;

use XML::Class;
use Method::Also;

use Amazon::AWS::EC2::Response::DescribePublicIpv4PoolsResponse;
use Amazon::AWS::Roles::Eqv;
use Amazon::AWS::Utils;

class Amazon::AWS::EC2::Action::DescribePublicIpv4Pools is export
  does XML::Class[
    xml-element   => 'DescribePublicIpv4Pools',
    xml-namespace => 'http://ec2.amazonaws.com/doc/2016-11-15/'
  ]
{
  also does Amazon::AWS::Roles::Eqv;

  my $c = ::?CLASS.^name.split('::')[* - 1];

  has Int                 $.MaxResults                              is xml-element          is rw;
  has Str                 @.Pools       is xml-container('poolSet') is xml-element('item')  is rw;
  #has Str                 $.NextToken      is xml-element    is rw;

  # How to handle use of nextToken? -- TBD
  # Ways to handle: - Max number of requests
  #                 - All in one (no user control)
  #                 - One page (and then pass the next token).

  submethod BUILD (
    :@pools,
    :$maxResults,
    # For deserialization purposes ONLY
    :@!Pools,
    :$!MaxResults = 10,
    #:$!nextToken  = '',
  ) {
    if $maxResults.defined {
      die ':$maxResults must be a number from 1 to 10'
        unless $maxResults ~~ 1..10;
      $!MaxResults = $maxResults;
    }
    
    if @pools {
      @!Pools = do given @pools {
        when .all ~~ Str    { @pools }

        default {
          die qq:to/DIE/.chomp;
          Invalid value passed to \@pools. Should only contain Str objects, but contains:
          { @pools.map( *.^name ).unique.join('. ') }
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
    my @PoolArgs;
    my $cnt = 1;
    @PoolArgs.push: Pair.new("PoolId.{$cnt++}", $_) for @!Pools;

    # Should already be sorted.
    my @args;

    if $nextToken.chars {
      @args = ( nextToken => $nextToken );
    } else {
      @args = (
        MaxResults     => $.MaxResults,
      );
      @args.append: @PoolArgs if @PoolArgs;
      @args.append: (
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
