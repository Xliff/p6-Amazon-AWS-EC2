use v6.c;

use Method::Also;
use XML::Class;

use Amazon::AWS::EC2::Filters::DescribeKeyPairsFilter;
use Amazon::AWS::EC2::Response::DescribeKeyPairsResponse;
use Amazon::AWS::EC2::Types::Instance;
use Amazon::AWS::Utils;

use Amazon::AWS::Roles::Eqv;

class Amazon::AWS::EC2::Action::DescribeKeyPairs is export
  does XML::Class[xml-element => 'DescribeKeyPairs']
{
  also does Amazon::AWS::Roles::Eqv;
  
  my $c = ::?CLASS.^name.split('::')[* - 1];

  has Bool                   $.DryRun                                        is xml-element                is rw;
  has DescribeKeyPairsFilter @.Filters     is xml-container('filterSet')                                   is rw;
  has Str                    @.KeyNames    is xml-container('keyNameSet')    is xml-element('keyName')     is rw;

  submethod BUILD (
    :$dryRun,
    :@filters,
    :@keyNames,
    # Testing purposes only!
    :$!DryRun = False,
    :@!Filters,
    :@!KeyNames
  ) {
    $!DryRun = $dryRun if $dryRun;
    
    if @filters {
      @!Filters = do given @filters {
        when .all ~~ DescribeKeyPairsFilter
          { @filters }

        default {
          die qq:to/DIE/.chomp;
  Invalid value passed to \@Filters. Should only contain DescribeKeyPairsFilter objects, but contains:
  { @filters.grep( * !~~ DescribeKeyPairsFilter).map( *.^name ).unique.join(', ') }
  DIE

        }
      }
    }

    # This can be expanded top anything that returns a regionId
    if @keyNames {
      die qq:to/DIE/.chomp unless @keyNames.all ~~ Str;
  Invalid value passed to \@keyNames. Should only strings, but contains:
  { @keyNames.grep( * !~~ Str ).map( *.^name ).unique.join(', ') }
  DIE

      @!KeyNames = @keyNames;
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
      @FilterArgs.push: Pair.new("Filter.{$cnt++}.{.key}", urlEncode(.value)) 
        for .pairs;
    }

    $cnt = 1;
    my @KeyNameArgs;
    @KeyNameArgs.push: Pair.new("KeyName.{$cnt++}", urlEncode($_)) 
      for @!KeyNames;

    # Should already be sorted.
    my @args = (
      DryRun         => $!DryRun,
      |@FilterArgs,
      |@KeyNameArgs,
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
