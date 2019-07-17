use v6.c;

use XML::Class;
use Method::Also;

use Amazon::AWS::EC2::Filters::DescribeVpcEndpointConnectionsFilter;
use Amazon::AWS::EC2::Response::DescribeVpcEndpointConnectionsResponse;
use Amazon::AWS::Utils;

class Amazon::AWS::EC2::Action::DescribeVpcEndpointConnections is export
  does XML::Class[
    xml-element   => 'DescribeVpcEndpointConnections',
    xml-namespace => 'http://ec2.amazonaws.com/doc/2016-11-15/'
  ]
{
  also does Amazon::AWS::Roles::Eqv;

  my $c = ::?CLASS.^name.split('::')[* - 1];

  has DescribeVpcEndpointConnectionsFilter @.Filters     is xml-container('filterSet')                                               is xml-skip-null is rw;
  has Bool                                 $.DryRun                                              is xml-element                      is xml-skip-null is rw;
  has Int                                  $.MaxResults                                          is xml-element                      is xml-skip-null is rw;
  
  # How to handle use of nextToken? -- TBD
  # Ways to handle: - Max number of requests
  #                 - All in one (no user control)
  #                 - One page (and then pass the next token).

  submethod BUILD (
    :$dryRun,
    :@filters,
    :$maxResults,
    # Reserved for testing purposes only!
    :$!DryRun      = False,
    :@!Filters,
    :$!MaxResults  = 1000
  ) {
    $!DryRun     = $dryRun     if $dryRun.defined;
    $!MaxResults = $maxResults if $maxResults.defined;
    
    die 'MaxResults must be an integer from 1 to 1000'
      unless $!MaxResults ~~ 5..1000;

    if @filters {
      @!Filters //= do given @filters {
        when .all ~~ DescribeVpcEndpointConnectionsFilter      
          { @filters }

        default {
          die qq:to/DIE/.chomp;
          Invalid value passed to \@filers. Should only contain DescribeVpcEndpointConnectionsFilter objects, but contains:
          { @filters.grep( * !~~ DescribeVpcEndpointConnectionsFilter ).map( *.^name ).unique.join('. ') }
          DIE

        }
      };
    }
    
  }

  method run (:$raw)
    is also<
      do
      execute
    >
  {
    my @FilterArgs;
    my $cnt = 1;
    for @!Filters {
      @FilterArgs.push: 
        Pair.new("Filter.{$cnt++}.{.key}", urlEncode(.value)) 
          for .pairs;
    }
    
    # Should already be sorted.
    my @args = (
      DryRun         => $!DryRun,
      |@FilterArgs,
      MaxResults     => $!MaxResults,
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
