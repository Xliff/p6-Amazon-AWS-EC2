use v6.d;

use Method::Also;
use XML::Class;

use Amazon::AWS::Utils;
use Amazon::AWS::Roles::Eqv;

use Amazon::AWS::EC2::Filters::DescribeFpgaImagesFilter;
use Amazon::AWS::EC2::Response::DescribeFpgaImagesResponse;;


class Amazon::AWS::EC2::Action::DescribeFpgaImages is export
  does XML::Class[xml-element => 'DescribeFpgaImages']
{
  also does Amazon::AWS::Roles::Eqv;

  my $c = ::?CLASS.^name.split('::')[* - 1];

  has Bool                      $.DryRun                                          is xml-element                        is xml-skip-null is rw;
  has DescribeFpgaImagesFilter  @.Filters        is xml-container('filterSet')                                          is xml-skip-null is rw;
  has Str                       @.FpgaImageIds   is xml-container('fpgaIdSet')    is xml-element('item', :over-ride)    is xml-skip-null is rw;
  has Str                       @.OwnerIds       is xml-container('ownerSet')     is xml-element('item', :over-ride)    is xml-skip-null is rw;
  has Int                       $.MaxResults                                      is xml-element                        is xml-skip-null is rw;

  submethod BUILD (
    :$dryRun,
    :@filters,
    :@fpgaImageIds,
    :$maxResults,
    :@ownerIds,
    # Testing purposes only!
    :$!DryRun        = False,
    :@!Filters,
    :@!FpgaImageIds,
    :$!MaxResults     = 500,
    :@!OwnerIds,
  ) {
    $!MaxResults = $maxResults if $maxResults.defined;

    if @filters {
      @!Filters = do given @filters {
        when .all ~~ DescribeFpgaImagesFilter    { @filters }

        default {
          die qq:to/DIE/.chomp;
  Invalid value passed to \@Filters. Should only contain DescribeFpgaImagesFilter objects, but contains:
  { @filters.grep( * !~~ DescribeFpgaImagesFilter).map( *.^name ).unique.join(', ') }
  DIE

        }
      }
    }

    # This can be expanded top anything that returns a regionId
    if @fpgaImageIds {
      die qq:to/DIE/.chomp unless @fpgaImageIds.all ~~ Str;
  Invalid value passed to \@fpgaImageIds. Should only strings, but contains:
  { @fpgaImageIds.grep( * !~~ Str ).map( *.^name ).unique.join(', ') }
  DIE

      @!FpgaImageIds = @fpgaImageIds;
    }

    # This can be expanded top anything that returns a regionId
    if @ownerIds {
      die qq:to/DIE/.chomp unless @ownerIds.all ~~ Str;
  Invalid value passed to \@ownerIds. Should only strings, but contains:
  { @ownerIds.grep( * !~~ Str ).map( *.^name ).unique.join(', ') }
  DIE

      @!OwnerIds = @ownerIds;
    }

  }

  method run (:$raw = False)
    is also<
      do
      execute
    >
  {
    # Needs more thought!
    my $cnt = 1;
    my @FilterArgs;
    for @!Filters {
      @FilterArgs.push: Pair.new("Filter.{$cnt}.{.key}", urlEncode(.value))
        for .pairs;
      $cnt++;
    }

    $cnt = 1;
    my @FpgaImageIdArgs;
    @FpgaImageIdArgs.push: Pair.new("FpgaImageId.{$cnt++}", $_)
      for @!FpgaImageIds;

    $cnt = 1;
    my @OwnerIdArgs;
    @OwnerIdArgs.push: Pair.new("OwnerId.{$cnt++}", $_)
      for @!OwnerIds;

    # Should already be sorted.
    my @args = (
      DryRun         => $!DryRun,
      |@FilterArgs,
      |@FpgaImageIdArgs,
      MaxResults     => $!MaxResults,
      |@OwnerIdArgs,
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
