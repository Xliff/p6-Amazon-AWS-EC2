use v6.d;

use XML::Class;
use Method::Also;

use Amazon::AWS::Utils;
use Amazon::AWS::Roles::Eqv;

use Amazon::AWS::EC2::Filters::DescribeVpcEndpointsFilter;
use Amazon::AWS::EC2::Response::DescribeVpcEndpointsResponse;

class Amazon::AWS::EC2::Action::DescribeVpcEndpoints is export
  does XML::Class[
    xml-element   => 'DescribeVpcEndpoints',
    xml-namespace => 'http://ec2.amazonaws.com/doc/2016-11-15/'
  ]
{
  also does Amazon::AWS::Roles::Eqv;

  my $c = ::?CLASS.^name.split('::')[* - 1];

  has DescribeVpcEndpointsFilter @.Filters          is xml-container('filterSet')           is xml-element('item', :over-ride)  is xml-skip-null is rw;
  has Str                        @.VpcEndpointIds   is xml-container('vpcEndpointsIdSet')   is xml-element('item', :over-ride)  is xml-skip-null is rw;
  has Bool                       $.DryRun                                                   is xml-element                      is xml-skip-null is rw;
  has Int                        $.MaxResults                                               is xml-element                      is xml-skip-null is rw;
  
  # How to handle use of nextToken? -- TBD
  # Ways to handle: - Max number of requests
  #                 - All in one (no user control)
  #                 - One page (and then pass the next token).

  submethod BUILD (
    :$dryRun,
    :@filters,
    :@vpcEndpointIds,
    :$maxResults,
    # Reserved for testing purposes only!
    :$!DryRun      = False,
    :@!Filters,
    :@!VpcEndpointIds,
    :$!MaxResults  = 1000
  ) {
    $!DryRun     = $dryRun     if $dryRun;
    $!MaxResults = $maxResults if $maxResults.defined;
    
    die 'MaxResults must be an integer from 1 to 1000'
      unless $!MaxResults ~~ 1..1000;
    
    if @vpcEndpointIds {
      die '@VpcEndpointsIds must only contain strings'
       unless @vpcEndpointIds.all ~~ Str;
      @!VpcEndpointIds = @vpcEndpointIds
    }

    if @filters {
      @!Filters //= do given @filters {
        when .all ~~ DescribeVpcEndpointsFilter      { @filters }

        default {
          die qq:to/DIE/.chomp;
          Invalid value passed to \@filers. Should only contain DescribeVpcEndpointsFilter objects, but contains:
          { @filters.grep( * !~~ DescribeVpcEndpointsFilter ).map( *.^name ).unique.join('. ') }
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
    my @VpcEndpointIdArgs;
    my $cnt = 1;
    for @!VpcEndpointIds {
      @VpcEndpointIdArgs.push: Pair.new("VpcEndpointId.{$cnt++}.{.key}", .value)
        for .pairs;
    }

    my @FilterArgs;
    $cnt = 1;
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
      Version        => '2016-11-15',
      |@VpcEndpointIdArgs
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
