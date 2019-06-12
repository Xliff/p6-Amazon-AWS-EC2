use v6.c;

use XML::Class;
use Method::Also;

use Amazon::AWS::EC2::Filters::DescribeVolumesFilter;
use Amazon::AWS::EC2::Response::DescribeVolumesResponse;
use Amazon::AWS::EC2::Types::Volume;
use Amazon::AWS::Utils;

class Amazon::AWS::EC2::Action::DescribeVolumes is export
  does XML::Class[
    xml-element   => 'DescribeVolumes',
    xml-namespace => 'http://ec2.amazonaws.com/doc/2016-11-15/'
  ]
{
  my $c = ::?CLASS.^name.split('::')[* - 1];

  has Bool                           $.DryRun                                       is xml-element               is rw;
  has Str                            @.volumeIds   is xml-container('volumeIdSet')  is xml-element('volumeId')   is rw;
  has DescribeVolumesFilter          @.filters     is xml-container('filterSet')    is xml-element               is rw;
  has Int                            $.maxResults                                   is xml-element               is rw;
  has Str                            $.nextToken                                    is xml-element               is rw;

  # How to handle use of nextToken? -- TBD
  # Ways to handle: - Max number of requests
  #                 - All in one (no user control)
  #                 - One page (and then pass the next token).

  submethod BUILD (
    :$!DryRun     = False,
    :$!maxResults = 1000,
    :$!nextToken  = '',
    :@filters    is copy = (),
    :@volumeIds  is copy = (),
  ) {
    die ':$maxResults must be a number from 5 to 1000'
      unless $!maxResults ~~ 5..1000;

    @filters = do given @filters {
      when .all ~~ Amazon::AWS::EC2::Filters::DescribeVolumesFilter { @filters }

      default {
        die qq:to/DIE/.chomp;
        Invalid value passed to \@filers. Should only contain Filters::DescribeSecurityGroup objects, but contains:
        { @filters.map( *.^name ).unique.join('. ') }
        DIE

      }
    };
    
    @!volumeIds = @volumeIds.map({
      do {
        when Str     { $_       }
        when Volume  { .volumeId }
        default      { die "Invalid type '{ .^name }' in \@volumeIds!" }
      }
    }).unique;

  }

  method run (:$nextToken = '', :$raw = False)
    is also<
      do
      execute
    >
  {
    my @FilterArgs;
    my $cnt = 1;
    for @.filters {
      @FilterArgs.push: Pair.new("Filter.{$cnt++}.{.key}", .value) for .pairs;
    }
    
   $cnt = 1;
   my @VolumeIdArgs;
   @VolumeIdArgs.push: Pair.new("VolumeId.{$cnt++}", $_) for @.volumeIds;


    # Should already be sorted.
    my @args;

    if $nextToken.chars {
      @args = ( nextToken => $nextToken );
    } else {
      @args = (
        DryRun         => $.DryRun,
        |@FilterArgs,
        |@VolumeIdArgs,
        MaxResults     => $.maxResults,
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
      Amazon::AWS::EC2::Response::DescribeVolumesResponse.from-xml($xml);
  }

}
