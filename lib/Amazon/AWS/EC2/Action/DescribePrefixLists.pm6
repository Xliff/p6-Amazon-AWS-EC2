use v6.d;

use Method::Also;
use XML::Class;

use Amazon::AWS::Utils;
use Amazon::AWS::Roles::Eqv;

use Amazon::AWS::EC2::Filters::DescribePrefixListsFilter;
use Amazon::AWS::EC2::Response::DescribePrefixListsResponse;

use Amazon::AWS::EC2::Types::Instance;

class Amazon::AWS::EC2::Action::DescribePrefixLists is export
  does XML::Class[xml-element => 'DescribePrefixLists']
{
  also does Amazon::AWS::Roles::Eqv;

  my $c = ::?CLASS.^name.split('::')[* - 1];

  has Bool                      $.DryRun                                             is xml-element             is xml-skip-null is rw;
  has DescribePrefixListsFilter @.Filters          is xml-container('filterSet')                                is xml-skip-null is rw;
  has Str                       @.PrefixListIds    is xml-container('keyNameSet')    is xml-element('item')     is xml-skip-null is rw;
  has Int                       $.MaxResults                                         is xml-element             is xml-skip-null is rw;

  submethod BUILD (
    :$dryRun,
    :@filters,
    :@prefixListIds,
    :$maxResults,
    # Testing purposes only!
    :$!DryRun        = False,
    :@!Filters,
    :$!MaxResults    = 100,
    :@!PrefixListIds,
  ) {
    $!DryRun     = $dryRun     if $dryRun;
    $!MaxResults = $maxResults if $maxResults.defined;
    die 'MaxResults must be an integer between 5 and 100'
      unless $!MaxResults ~~ 5..100;

    if @filters {
      @!Filters = do given @filters {
        when .all ~~ DescribePrefixListsFilter    { @filters }

        default {
          die qq:to/DIE/.chomp;
  Invalid value passed to \@Filters. Should only contain DescribePrefixListsFilter objects, but contains:
  { @filters.grep( * !~~ DescribePrefixListsFilter).map( *.^name ).unique.join(', ') }
  DIE

        }
      }
    }

    # This can be expanded top anything that returns a regionId
    if @prefixListIds {
      die qq:to/DIE/.chomp unless @prefixListIds.all ~~ Str;
  Invalid value passed to \@keyNames. Should only strings, but contains:
  { @prefixListIds.grep( * !~~ Str ).map( *.^name ).unique.join(', ') }
  DIE

      @!PrefixListIds = @prefixListIds;
    }

  }

  method run (:$nextToken = '', :$raw = False)
    is also<
      do
      execute
    >
  {
    # Needs more thought!
    my $cnt = 1;
    my @FilterArgs;
    for @.Filters {
      @FilterArgs.push: Pair.new("Filter.{$cnt}.{.key}", urlEncode(.value))
        for .pairs;
      $cnt++;
    }

    $cnt = 1;
    my @PrefixListArgs;
    @PrefixListArgs.push: Pair.new("PrefixListId.{$cnt++}", $_) for @.PrefixListIds;

    my @args;
    if $nextToken.chars {
      @args = ( nextToken => $nextToken );
    } else {
      # Should already be sorted.
      @args = (
        DryRun         => $!DryRun,
        |@FilterArgs,
        |@PrefixListArgs,
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
