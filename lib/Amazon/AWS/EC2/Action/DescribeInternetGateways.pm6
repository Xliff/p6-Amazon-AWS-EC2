use v6.d;

use XML::Class;
use Method::Also;

use Amazon::AWS::Utils;
use Amazon::AWS::Roles::Eqv;

use Amazon::AWS::EC2::Filters::DescribeInternetGatewaysFilter;
use Amazon::AWS::EC2::Response::DescribeInternetGatewaysResponse;

use Amazon::AWS::EC2::Types::Volume;

class Amazon::AWS::EC2::Action::DescribeInternetGateways is export
  does XML::Class[
    xml-element   => 'DescribeInternetGateways',
    xml-namespace => 'http://ec2.amazonaws.com/doc/2016-11-15/'
  ]
{
  also does Amazon::AWS::Roles::Eqv;

  my $c = ::?CLASS.^name.split('::')[* - 1];

  has DescribeInternetGatewaysFilter  @.Filters               is xml-container('filterSet')             is xml-element         is xml-skip-null is rw;
  has Bool                            $.DryRun                                                          is xml-element         is xml-skip-null is rw;
  has Str                             @.InternetGatewaysIds   is xml-container('networkInterfaceIdSet') is xml-element('item') is xml-skip-null is rw;
  has Int                             $.MaxResults                                                      is xml-element         is xml-skip-null is rw;

  # How to handle use of nextToken? -- TBD
  # Ways to handle: - Max number of requests
  #                 - All in one (no user control)
  #                 - One page (and then pass the next token).
  
  submethod BUILD (
    :@filters,
    :$dryRun,
    :@internetGatewaysIds,
    :$maxResults,
    # For testing purposes only
    :@!Filters,
    :$!DryRun               = False,
    :@!InternetGatewaysIds,
    :$!MaxResults           = 1000
  ) {
    $!DryRun = $dryRun if $dryRun;
    
    die '$maxResutlts must be an integer between 5 and 1000'
      unless $!MaxResults ~~ 5..1000;
      
    if @internetGatewaysIds {
      @!InternetGatewaysIds = @internetGatewaysIds.map({
        do {
          when Str      { $_          }

          default {
            die qq:to/DIE/.chomp;
             Invalid value passed to \@InternetGatewaysIds. Should only contain Str objects, but contains:
            { @internetGatewaysIds.map( *.^name ).unique.join(', ') }
            DIE

          }
        }
      }).flat;
    }

    if @filters {
      @!Filters = do given @filters {
        when .all ~~ Amazon::AWS::EC2::Filters::DescribeInternetGatewaysFilter 
          { @filters }

        default {
          die qq:to/DIE/.chomp;
          Invalid value passed to \@filers. Should only contain DescribeInternetGatewaysFilter objects, but also contains:
          { @filters.grep( * !~~ Str).map( *.^name ).unique.join('. ') }
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
    # cw: Not mentioned at https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_DescribeInternetGatewayss.html
    # but left in case it was an oversight.
    #
    # die 'Cannot use @.NetworkInterfaceIds and $.maxResults in the same call to DescribeInternetGatewayss'
    #   if $.MaxResults.defined && @.NetworkInterfaceIds;   

    my $cnt = 1;
    my @InternetGatewaysIdArgs;
    @InternetGatewaysIdArgs.push: 
      Pair.new("InternetGatewaysId.{$cnt++}", $_) 
        for @!InternetGatewaysIds;

    my @FilterArgs;
    $cnt = 1;
    for @!Filters {
      @FilterArgs.push: Pair.new("Filter.{$cnt++}.{.key}", urlEncode(.value)) 
        for .pairs;
    }

    # Should already be sorted.
    my @args;

    if $nextToken.chars {
      @args = ( nextToken => $nextToken );
    } else {
      @args = (
        DryRun         => $!DryRun,
        |@FilterArgs,
        |@InternetGatewaysIdArgs,
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
