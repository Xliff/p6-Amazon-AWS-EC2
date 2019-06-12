use v6.c;

use Method::Also;
use XML::Class;

use Amazon::AWS::EC2::Filters::DescribeKeyPairsFilter;
use Amazon::AWS::EC2::Response::DescribeKeyPairsResponse;
use Amazon::AWS::EC2::Types::Instance;
use Amazon::AWS::Utils;

class Amazon::AWS::EC2::Action::DescribeKeyPairs is export
  does XML::Class[xml-element => 'DescribeKeyPairs']
{
  my $c = ::?CLASS.^name.split('::')[* - 1];

  has Bool                   $.DryRun                                        is xml-element                is rw;
  has DescribeKeyPairsFilter @.filters     is xml-container('filterSet')                                   is rw;
  has Str                    @.KeyNames    is xml-container('keyNameSet')    is xml-element('keyName')     is rw;

  submethod BUILD (
    :$!DryRun = False,
    :@Filters,
    :@KeyNames
  ) {
    @!filters = do given @Filters {
      when .all ~~ DescribeKeyPairsFilter { @Filters }

      default {
        die qq:to/DIE/.chomp;
Invalid value passed to \@Filters. Should only contain DescribeKeyPairsFilter objects, but contains:
{ @Filters.grep( * !~~ DescribeKeyPairsFilter).map( *.^name ).unique.join(', ') }
DIE

      }
    }

    # This can be expanded top anything that returns a regionId
    die qq:to/DIE/.chomp unless @KeyNames.all ~~ Str;
Invalid value passed to \@keyNames. Should only strings, but contains:
{ @KeyNames.grep( * !~~ Str ).map( *.^name ).unique.join(', ') }
DIE

    @!KeyNames = @KeyNames;
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
    for @.filters {
      @FilterArgs.push: Pair.new("Filter.{$cnt++}.{.key}", .value) for .pairs;
    }

    $cnt = 1;
    my @KeyNameArgs;
    @KeyNameArgs.push: Pair.new("KeyName.{$cnt++}", $_) for @.KeyNames;

    # Should already be sorted.
    my @args = (
      DryRun         => $.DryRun,
      |@FilterArgs,
      |@KeyNameArgs,
      Version        => '2016-11-15'
    );

    # XXX - Add error handling to makeRequest!
    my $xml = makeRequest(
      "?Action=DescribeKeyPairs&{ @args.map({ "{.key}={.value}" }).join('&') }"
    );

    $raw ??
      $xml
      !!
      Amazon::AWS::EC2::Response::DescribeKeyPairsResponse.from-xml($xml);
  }

}
