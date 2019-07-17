use v6.c;

use XML::Class;
use Method::Also;

use Amazon::AWS::EC2::Filters::DescribeVolumeStatusFilter;
use Amazon::AWS::EC2::Response::DescribeVolumeStatusResponse;
use Amazon::AWS::EC2::Types::Instance;
use Amazon::AWS::EC2::Types::Snapshot;
use Amazon::AWS::EC2::Types::Volume;
use Amazon::AWS::Utils;
use Amazon::AWS::Roles::Eqv;

class Amazon::AWS::EC2::Action::DescribeVolumeStatus is export
  does XML::Class[
    xml-element   => 'DescribeVolumeStatus',
    xml-namespace => 'http://ec2.amazonaws.com/doc/2016-11-15/'
  ]
{
  also does Amazon::AWS::Roles::Eqv;

  my $c = ::?CLASS.^name.split('::')[* - 1];

  has Bool                        $.DryRun                                        is xml-element             is rw;
  has DescribeVolumeStatusFilter  @.Filters     is xml-container('filterSet')     is xml-element             is rw;
  has Int                         $.MaxResults                                    is xml-element             is rw;
  has Str                         @.VolumeIds   is xml-container('volumeIdSet')   is xml-element('iitem')    is rw;
  #has Str                         $.NextToken                                     is xml-element               is rw;

  # How to handle use of nextToken? -- TBD
  # Ways to handle: - Max number of requests
  #                 - All in one (no user control)
  #                 - One page (and then pass the next token).

  submethod BUILD (
    :$dryRun,
    :@filters,
    :$maxResults,
    :@volumeIds,
    # For testing purposes only
    :$!DryRun     = False,
    :@!Filters,
    :$!MaxResults = 0,
    :@!VolumeIds,
    # :$!NextToken  = '',
  ) {
    $!DryRun     = $dryRun     if $dryRun;
    $!MaxResults = $maxResults if $maxResults.defined;
    
    if @volumeIds {
      my @valid-types = (Str, Instance, Snapshot, Volume);
      @!VolumeIds = @volumeIds.map({
        do {
          when Str      { $_                 }
          when Instance { .volumeId          }
          when Snapshot { .volumeId          }
          when Volume   { .snapshot.volumeId }

          default {
            die qq:to/DIE/.chomp;
            Invalid value passed to \@volumes. Should only contain VolumeId-compatible objects. 
            Invalid objects found: { 
              @volumeIds.map( * !~~ @valid-types.any ).unique.join(', ') 
            }
            DIE

          }
        }
      }).flat;
    }

    if @filters {
      @!Filters = do given @filters {
        when .all ~~ DescribeVolumeStatusFilter { @filters }

        default {
          die qq:to/DIE/.chomp;
          Invalid value passed to \@filers. Should only contain Filter objects, but contains:
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
    die 'Cannot use volumes and maxResults in the same call to DescribeVolumeStatus'
      if $!MaxResults && @!VolumeIds;

    my @FilterArgs;
    my $cnt = 1;
    for @!Filters {
      @FilterArgs.push: Pair.new("Filter.{$cnt++}.{.key}", urlEncode(.value))
        for .pairs;
    }
    
    $cnt = 1;
    my @VolumeArgs;
    @VolumeArgs.push: Pair.new("VolumeId.{$cnt++}", $_) for @!VolumeIds;

    # Should already be sorted.
    my @args;

    if (my $nt = $nextToken.trim).chars {
      @args = ( nextToken => $nt );
    } else {
      @args = (
         DryRun => $!DryRun,
         |@FilterArgs
      );
      @args.push: (MaxResults => $!MaxResults) if $!MaxResults;
      @args.append: (
        Version => '2016-11-15',
        |@VolumeArgs
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
