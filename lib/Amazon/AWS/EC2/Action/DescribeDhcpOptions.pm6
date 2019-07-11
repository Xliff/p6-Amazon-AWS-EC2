use v6.c;

use XML::Class;
use Method::Also;

use Amazon::AWS::EC2::Filters::DescribeDhcpOptionsFilter;
use Amazon::AWS::EC2::Response::DescribeDhcpOptionsResponse;
use Amazon::AWS::Utils;

class Amazon::AWS::EC2::Action::DescribeDhcpOptions is export
  does XML::Class[
    xml-element   => 'DescribeDhcpOptions',
    xml-namespace => 'http://ec2.amazonaws.com/doc/2016-11-15/'
  ]
{
  also does Amazon::AWS::Roles::Eqv;

  my $c = ::?CLASS.^name.split('::')[* - 1];

  has DescribeDhcpOptionsFilter @.Filters          is xml-container('filterSet')           is xml-element('item', :over-ride)  is xml-skip-null is rw;
  has Str                       @.DhcpOptionIds    is xml-container('dhcpOptionsIdSet')    is xml-element('item', :over-ride)  is xml-skip-null is rw;
  has Bool                      $.DryRun                                                   is xml-element                      is xml-skip-null is rw;
  has Int                       $.MaxResults                                               is xml-element                      is xml-skip-null is rw;
  
  # How to handle use of nextToken? -- TBD
  # Ways to handle: - Max number of requests
  #                 - All in one (no user control)
  #                 - One page (and then pass the next token).

  submethod BUILD (
    :$dryRun,
    :@filters,
    :@dhcpOptionIds,
    :$maxResults,
    # Reserved for testing purposes only!
    :$!DryRun      = False,
    :@!Filters,
    :@!DhcpOptionIds,
    :$!MaxResults  = 1000
  ) {
    $!DryRun = $dryRun         if $dryRun.defined;
    $!MaxResults = $maxResults if $maxResults.defined;
    
    if @dhcpOptionIds {
      die '@dhcpOptionsIds must only contain strings'
       unless @dhcpOptionIds.all ~~ Str;
      @!DhcpOptionIds = @dhcpOptionIds
    }

    if @filters {
      @!Filters //= do given @filters {
        when .all ~~ DescribeDhcpOptionsFilter      { @filters }

        default {
          die qq:to/DIE/.chomp;
          Invalid value passed to \@filers. Should only contain DescribeDhcpOptionsFilter objects, but contains:
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
    my @DhcpOptionIdArgs;
    my $cnt = 1;
    for @!DhcpOptionIds {
      @DhcpOptionIdArgs.push: Pair.new("DhcpOptionId.{$cnt++}.{.key}", .value)
        for .pairs;
    }

    my @FilterArgs;
    $cnt = 1;
    for @!Filters {
      @FilterArgs.push: Pair.new("Filter.{$cnt++}.{.key}", .value) for .pairs;
    }
    
    # Should already be sorted.
    my @args = (
      DryRun         => $.DryRun,
      |@DhcpOptionIdArgs,
      |@FilterArgs,
      MaxResults     => $.MaxResults,
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
