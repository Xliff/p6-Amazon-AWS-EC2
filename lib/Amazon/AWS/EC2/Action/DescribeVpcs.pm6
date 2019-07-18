use v6.c;

use XML::Class;
use Method::Also;

use Amazon::AWS::EC2::Filters::DescribeVpcsFilter;
use Amazon::AWS::EC2::Response::DescribeVpcsResponse;
use Amazon::AWS::EC2::Types::Volume;
use Amazon::AWS::Utils;
use Amazon::AWS::Roles::Eqv;

class Amazon::AWS::EC2::Action::DescribeVpcs is export
  does XML::Class[
    xml-element   => 'DescribeVpcs',
    xml-namespace => 'http://ec2.amazonaws.com/doc/2016-11-15/'
  ]
{
  also does Amazon::AWS::Roles::Eqv;

  my $c = ::?CLASS.^name.split('::')[* - 1];

  has DescribeVpcsFilter  @.Filters    is xml-container('filterSet')             is xml-element         is rw;
  has Bool                $.DryRun                                               is xml-element         is rw;
  has Str                 @.VpcIds     is xml-container('networkInterfaceIdSet') is xml-element('item') is rw;
  has Int                 $.MaxResults                                           is xml-element         is rw;

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
    $!MaxResults = $maxResults if $maxResults.defined;
    
    die 'MaxResutlts must be an integer between 5 and 1000'
      unless $!MaxResults ~~ 5..1000;
      
    if @vpcIds {
      @!VpcIds = @vpcIds.map({
        do {
          when Str      { $_          }

          default {
            die qq:to/DIE/.chomp;
             Invalid value passed to \@vpcIds. Should only contain Str objects, but contains:
            { @vpcIds.map( *.^name ).unique.join(', ') }
            DIE

          }
        }
      }).flat;
    }

    if @filters {
      @!Filters = do given @filters {
        when .all ~~ Amazon::AWS::EC2::Filters::DescribeVpcsFilter { @filters }

        default {
          die qq:to/DIE/.chomp;
          Invalid value passed to \@filers. Should only contain DescribeVpcsFilter objects, but contains:
          { @filters.map( *.^name ).unique.join('. ') }
          DIE

        }
      };
    }

  }

  method run (Str :$nextToken is copy, :$raw)
    is also<
      do
      execute
    >
  {
    $nextToken //= '';
    
    # cw: Not mentioned at https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_DescribeVpcs.html
    # but left in case it was an oversight.
    #
    # die 'Cannot use @.NetworkInterfaceIds and $.maxResults in the same call to DescribeVpcs'
    #   if $.MaxResults.defined && @.NetworkInterfaceIds;   

    my $cnt = 1;
    my @VpcIdArgs;
    @VpcIdArgs.push: Pair.new("VpcId.{$cnt++}", $_) for @!VpcIds;

    my @FilterArgs;
    $cnt = 1;
    for @!Filters {
      @FilterArgs.push: 
        Pair.new("Filter.{$cnt++}.{.key}", urlEncode(.value))
          for .pairs;
    }

    # Should already be sorted.
    my @args;

    if (my $nt = $nextToken.trim).chars {
      @args = ( nextToken => $nt );
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
