use v6.d;

use Method::Also;
use XML::Class;

use Amazon::AWS::Utils;
use Amazon::AWS::Roles::Eqv;

use Amazon::AWS::EC2::Filters::DescribePlacementGroupsFilter;
use Amazon::AWS::EC2::Response::DescribePlacementGroupsResponse;

use Amazon::AWS::EC2::Types::Instance;

class Amazon::AWS::EC2::Action::DescribePlacementGroups is export
  does XML::Class[xml-element => 'DescribePlacementGroups']
{
  also does Amazon::AWS::Roles::Eqv;

  my $c = ::?CLASS.^name.split('::')[* - 1];

  has Bool                          $.DryRun                                          is xml-element             is rw;
  has DescribePlacementGroupsFilter @.Filters     is xml-container('filterSet')                                  is rw;
  has Str                           @.GroupNames  is xml-container('groupNameSet')    is xml-element('item')     is rw;

  submethod BUILD (
    :$dryRun,
    :@filters,
    :@groupNames,
    # Testing purposes only!
    :$!DryRun = False,
    :@!Filters,
    :@!GroupNames
  ) {
    $!DryRun = $dryRun if $dryRun;

    if @filters {
      @!Filters = do given @filters {
        when .all ~~ DescribePlacementGroupsFilter    { @filters }

        default {
          die qq:to/DIE/.chomp;
  Invalid value passed to \@Filters. Should only contain DescribePlacementGroupsFilter objects, but contains:
  { @filters.grep( * !~~ DescribePlacementGroupsFilter).map( *.^name ).unique.join(', ') }
  DIE

        }
      }
    }

    # This can be expanded top anything that returns a regionId
    if @groupNames {
      die qq:to/DIE/.chomp unless @groupNames.all ~~ Str;
  Invalid value passed to \@keyNames. Should only strings, but contains:
  { @groupNames.grep( * !~~ Str ).map( *.^name ).unique.join(', ') }
  DIE

      @!GroupNames = @groupNames;
    }

  }

  method run (:$raw = False)
    is also<
      do
      execute
    >
  {
    my $cnt = 1;
    my @FilterArgs;
    for @!Filters {
      my $v = .value;
      $v = urlEncode($v) if .key eq 'GroupName';
      @FilterArgs.push: Pair.new("Filter.{$cnt}.{.key}", $v) for .pairs;
      $cnt++;
    }

    $cnt = 1;
    my @GroupNameArgs;
    @GroupNameArgs.push: Pair.new("GroupName.{$cnt++}", urlEncode($_))
      for @!GroupNames;

    # Should already be sorted.
    my @args = (
      DryRun         => $!DryRun,
      |@FilterArgs,
      |@GroupNameArgs,
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
