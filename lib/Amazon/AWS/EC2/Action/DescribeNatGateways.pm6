use v6.d;

use XML::Class;
use Method::Also;

use Amazon::AWS::Utils;
use Amazon::AWS::Roles::Eqv;

use Amazon::AWS::EC2::Filters::DescribeNatGatewaysFilter;
use Amazon::AWS::EC2::Response::DescribeNatGatewaysResponse;

class Amazon::AWS::EC2::Action::DescribeNatGateways is export
  does XML::Class[
    xml-element   => 'DescribeNatGateways',
    xml-namespace => 'http://ec2.amazonaws.com/doc/2016-11-15/'
  ]
{
  also does Amazon::AWS::Roles::Eqv;

  my $c = ::?CLASS.^name.split('::')[* - 1];

  has DescribeNatGatewaysFilter @.Filters          is xml-container('filterSet')                                               is xml-skip-null is rw;
  has Str                       @.NatGatewayIds    is xml-container('natGatewaysIdSet')    is xml-element('item', :over-ride)  is xml-skip-null is rw;
  has Bool                      $.DryRun                                                   is xml-element                      is xml-skip-null is rw;
  has Int                       $.MaxResults                                               is xml-element                      is xml-skip-null is rw;
  
  # How to handle use of nextToken? -- TBD
  # Ways to handle: - Max number of requests
  #                 - All in one (no user control)
  #                 - One page (and then pass the next token).

  submethod BUILD (
    :$dryRun,
    :@filters,
    :@natGatewayIds,
    :$maxResults,
    # Reserved for testing purposes only!
    :$!DryRun      = False,
    :@!Filters,
    :@!NatGatewayIds,
    :$!MaxResults  = 1000
  ) {
    $!DryRun     = $dryRun     if $dryRun;
    $!MaxResults = $maxResults if $maxResults.defined;
    
    if @natGatewayIds {
      die '@NatGatewaysIds must only contain strings'
       unless @natGatewayIds.all ~~ Str;
      @!NatGatewayIds = @natGatewayIds
    }

    if @filters {
      @!Filters //= do given @filters {
        when .all ~~ DescribeNatGatewaysFilter      { @filters }

        default {
          die qq:to/DIE/.chomp;
          Invalid value passed to \@filers. Should only contain DescribeNatGatewaysFilter objects, but contains:
          { @filters.map( *.^name ).unique.join('. ') }
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
    my @NatGatewayIdArgs;
    my $cnt = 1;
    for @!NatGatewayIds {
      @NatGatewayIdArgs.push: Pair.new("NatGatewayId.{$cnt++}", $_)
    }

    my @FilterArgs;
    $cnt = 1;
    for @!Filters {
      @FilterArgs.push: Pair.new("Filter.{$cnt++}.{.key}", urlEncode(.value))
        for .pairs;
    }
    
    # Should already be sorted.
    my @args = (
      DryRun         => $!DryRun,
      |@FilterArgs,
      MaxResults     => $!MaxResults,
      |@NatGatewayIdArgs,
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
