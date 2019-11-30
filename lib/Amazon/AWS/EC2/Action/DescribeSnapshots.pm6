use v6.d;

use XML::Class;
use Method::Also;

use Amazon::AWS::Utils;
use Amazon::AWS::Roles::Eqv;

use Amazon::AWS::EC2::Filters::DescribeSnapshotsFilter;
use Amazon::AWS::EC2::Response::DescribeSnapshotsResponse;

class Amazon::AWS::EC2::Action::DescribeSnapshots is export
  does XML::Class[
    xml-element   => 'DescribeSnapshots',
    xml-namespace => 'http://ec2.amazonaws.com/doc/2016-11-15/'
  ]
{
  also does Amazon::AWS::Roles::Eqv;

  my $c = ::?CLASS.^name.split('::')[* - 1];

  has Bool                     $.DryRun                                                 is xml-element                     is xml-skip-null is rw;
  has DescribeSnapshotsFilter  @.Filters         is xml-container('filterSet')          is xml-element('item', :over-ride) is xml-skip-null is rw;
  has Int                      $.MaxResults                                             is xml-element                     is xml-skip-null is rw;
  has Str                      @.Owners          is xml-container('ownerSet')           is xml-element('item', :over-ride) is xml-skip-null is rw;
  has Str                      @.RestorableBy    is xml-container('restorableBySet')    is xml-element('item', :over-ride) is xml-skip-null is rw;
  has Str                      @.SnapshotIds     is xml-container('snapshotIdSet')      is xml-element('item', :over-ride) is xml-skip-null is rw;

  # How to handle use of nextToken? -- TBD
  # Ways to handle: - Max number of requests
  #                 - All in one (no user control)
  #                 - One page (and then pass the next token).

  submethod BUILD (
    :$dryRun,
    :@filters,
    :$maxResults,
    :@owners       is copy,
    :@restorableBy is copy,
    :@snapshotIds  is copy,
    # Reserved for testing purposes only!
    :$!DryRun       = False,
    :@!Filters,
    :$!MaxResults   = 1000,
    :@!Owners,
    :@!RestorableBy,
    :@!SnapshotIds
  ) {
    $!DryRun     = $dryRun     if $dryRun.defined;
    $!MaxResults = $maxResults if $maxResults.defined;
    
    die '$maxResults must be an integer between 1..1000'
      unless $!MaxResults ~~ 1..1000;
    
    if @owners {
      die '@owners must only contain Str' unless @owners.all ~~ Str;
      @!Owners = @owners;
    }
    if @restorableBy {
      die '@restorableBy must only contain Str' unless @restorableBy.all ~~ Str;
      @!RestorableBy = @restorableBy;
    }
    if @snapshotIds {
      die '@snapshotIds must only contain Str' unless @snapshotIds.all ~~ Str;
      @!SnapshotIds = @snapshotIds;
    }

    if @filters {
      @!Filters //= do given @filters {
        when .all ~~ DescribeSnapshotsFilter    
          { @filters }

        default {
          die qq:to/DIE/.chomp;
          Invalid value passed to \@filers. Should only contain DescribeSnapshotsFilter objects, but contains:
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
    my @FilterArgs;
    my $cnt = 1;
    for @!Filters {
      @FilterArgs.push: Pair.new("Filter.{$cnt++}.{.key}", urlEncode(.value)) 
        for .pairs;
    }

    my @OwnerArgs;
    $cnt = 1;
    @OwnerArgs.push: Pair.new("Owner.{$cnt++}", $_) for @!Owners;
    
    # Expecting to be numeric, but if ARNs are acceptable, then these MUST
    # be url-encoded!
    my @RestorableByArgs;
    $cnt = 1;
    @RestorableByArgs.push: Pair.new("RestorableBy.{$cnt++}", $_) 
      for @!RestorableBy;

    my @SnapshotIdArgs;
    $cnt = 1;
    @SnapshotIdArgs.push: Pair.new("SnapshotId.{$cnt++}", $_) 
      for @!SnapshotIds;

    # Should already be sorted.
    my @args;
    if (my $nt = $nextToken.trim).chars {
      @args = ( nextToken => $nt );
    } else {
      @args = (
        DryRun              => $!DryRun,
        |@FilterArgs,
        MaxResults          => $!MaxResults,
        |@OwnerArgs,
        |@RestorableByArgs,
        |@SnapshotIdArgs,
        Version             => '2016-11-15'
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
