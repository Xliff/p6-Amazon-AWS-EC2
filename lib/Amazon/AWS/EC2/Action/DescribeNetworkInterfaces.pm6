use v6.c;

use XML::Class;
use Method::Also;

use Amazon::AWS::EC2::Filters::DescribeNetworkInterfacesFilter;
use Amazon::AWS::EC2::Response::DescribeNetworkInterfacesResponse;
use Amazon::AWS::EC2::Types::Volume;
use Amazon::AWS::Utils;
use Amazon::AWS::Roles::Eqv;

class Amazon::AWS::EC2::Action::DescribeNetworkInterfaces is export
  does XML::Class[
    xml-element   => 'DescribeNetworkInterfaces',
    xml-namespace => 'http://ec2.amazonaws.com/doc/2016-11-15/'
  ]
{
  also does Amazon::AWS::Roles::Eqv;

  my $c = ::?CLASS.^name.split('::')[* - 1];

  has DescribeNetworkInterfacesFilter  @.Filters             is xml-container('filterSet')             is xml-element         is rw;
  has Bool                             $.DryRun                                                        is xml-element         is rw;
  has Str                              @.NetworkInterfaceIds is xml-container('networkInterfaceIdSet') is xml-element('item') is rw;
  has Int                              $.MaxResults                                                    is xml-element         is rw;

  # How to handle use of nextToken? -- TBD
  # Ways to handle: - Max number of requests
  #                 - All in one (no user control)
  #                 - One page (and then pass the next token).
  
  submethod BUILD (
    :@filters,
    :$dryRun,
    :@networkInterfaceIds,
    :$maxResults,
    # For testing purposes only
    :@!Filters,
    :$!DryRun               = False,
    :@!NetworkInterfaceIds,
    :$!MaxResults           = 1000
  ) {
    die '$maxResutlts must be an integer between 5 and 1000'
      unless $!MaxResults ~~ 5..1000;
      
    if @networkInterfaceIds {
      @!NetworkInterfaceIds = @networkInterfaceIds.map({
        do {
          when Str      { $_          }

          default {
            die qq:to/DIE/.chomp;
             Invalid value passed to \@networkInterfaceIds. Should only contain Str objects, but contains:
            { @networkInterfaceIds.map( *.^name ).unique.join(', ') }
            DIE

          }
        }
      }).flat;
    }

    if @filters {
      @!Filters = do given @filters {
        when .all ~~ Amazon::AWS::EC2::Filters::DescribeNetworkInterfaces { @filters }

        default {
          die qq:to/DIE/.chomp;
          Invalid value passed to \@filers. Should only contain DescribeNetworkInterfaceFilter objects, but contains:
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
    # cw: Not mentioned at https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_DescribeNetworkInterfaces.html like others, 
    # but left in case it was an oversight.
    #
    # die 'Cannot use @.NetworkInterfaceIds and $.maxResults in the same call to DescribeNetworkInterfaces'
    #   if $.MaxResults.defined && @.NetworkInterfaceIds;   

    my $cnt = 1;
    my @NetworkInterfaceIdArgs;
    @NetworkInterfaceIdArgs.push: Pair.new("NetworkInterfaceId.{$cnt++}", $_) for @.InstanceIds;

    my @FilterArgs;
    $cnt = 1;
    for @!Filters {
      @FilterArgs.push: Pair.new("Filter.{$cnt++}.{.key}", .value) for .pairs;
    }

    # Should already be sorted.
    my @args;

    if $nextToken.chars {
      @args = ( nextToken => $nextToken );
    } else {
      @args = (
        DryRun         => $.DryRun,
        |@FilterArgs,
        |@NetworkInterfaceIdArgs,
        MaxResults     => $.MaxResults,
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
