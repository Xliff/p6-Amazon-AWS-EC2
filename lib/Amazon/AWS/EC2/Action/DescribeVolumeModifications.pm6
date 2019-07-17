use v6.c;

use XML::Class;
use Method::Also;

use Amazon::AWS::EC2::Filters::DescribeVolumeModificationsFilter;
use Amazon::AWS::EC2::Response::DescribeVolumeModificationsResponse;
use Amazon::AWS::EC2::Types::Volume;
use Amazon::AWS::Utils;

use Amazon::AWS::Roles::Eqv;

class Amazon::AWS::EC2::Action::DescribeVolumeModifications is export
  does XML::Class[
    xml-element   => 'DescribeVolumeModifications',
    xml-namespace => 'http://ec2.amazonaws.com/doc/2016-11-15/'
  ]
{
  also does Amazon::AWS::Roles::Eqv;
  
  my $c = ::?CLASS.^name.split('::')[* - 1];

  has Bool                               $.DryRun                                       is xml-element                       is rw;
  has Str                                @.VolumeIds   is xml-container('volumeIdSet')  is xml-element('item', :over-ride)   is rw;
  has DescribeVolumeModificationsFilter  @.Filters     is xml-container('filterSet')    is xml-element('item', :over-ride)   is rw;
  has Int                                $.MaxResults                                   is xml-element                       is rw;

  # How to handle use of nextToken? -- TBD
  # Ways to handle: - Max number of requests
  #                 - All in one (no user control)
  #                 - One page (and then pass the next token).

  submethod BUILD (
    :$dryRun,     
    :@filters,
    :$maxResults,
    :@volumeIds,
    #:$!nextToken  = '',
    # For Deserialization purposes!
    :$!DryRun     = False,
    :@!Filters,
    :$!MaxResults = 1000,
    :@!VolumeIds,
  ) {
    $!DryRun = $dryRun if $dryRun;
    if $maxResults.defined {
      die ':$maxResults must be a number from 1 to 500'
        unless $maxResults ~~ 1..500;
      $!MaxResults = $maxResults;
    }

    if @filters {
      @!Filters = do given @filters {
        when .all ~~ DescribeVolumeModificationsFilter    { @filters }

        default {
          die qq:to/DIE/.chomp;
          Invalid value passed to \@filers. Should only contain Filters::DescribeSecurityGroup objects, but contains:
          { @filters.map( *.^name ).unique.join('. ') }
          DIE
        }
      };
    }
    
    if @volumeIds {
      @!VolumeIds = @volumeIds.map({
        do {
          when Str     { $_       }
          when Volume  { .volumeId }
          default      { die "Invalid type '{ .^name }' in \@volumeIds!" }
        }
      }).unique;
    }

  }

  method run (Str :$nextToken is copy, :$raw = False)
    is also<
      do
      execute
    >
  {
    $nextToken //= '';
    
    my @FilterArgs;
    my $cnt = 1;
    for @!Filters {
      @FilterArgs.push: Pair.new("Filter.{$cnt++}.{.key}", urlEncode(.value)) 
        for .pairs;
    }
    
   $cnt = 1;
   my @VolumeIdArgs;
   @VolumeIdArgs.push: Pair.new("VolumeId.{$cnt++}", $_) for @!VolumeIds;

    # Should already be sorted.
    my @args;

    if (my $nt = $nextToken.trim).chars {
      @args = ( nextToken => $nt );
    } else {
      @args = (
        DryRun         => $!DryRun,
        |@FilterArgs,
        |@VolumeIdArgs,
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
