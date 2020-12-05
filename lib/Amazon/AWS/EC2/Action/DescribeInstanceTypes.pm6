use v6.d;

use Amazon::AWS::EC2::Types::Base;

use Method::Also;
use XML::Class;

use Amazon::AWS::Utils;
use Amazon::AWS::Roles::Eqv;

use Amazon::AWS::EC2::Filters::DescribeInstanceTypesFilter;
use Amazon::AWS::EC2::Response::DescribeInstanceTypesResponse;

use Amazon::AWS::EC2::Types::Instance;

class Amazon::AWS::EC2::Action::DescribeInstanceTypes is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::Roles::Eqv;

  my $c = ::?CLASS.^name.split('::')[* - 1];

  has Bool                         $.DryRun            is xml-element                       is xml-skip-null                                            is rw;
  has DescribeInstanceTypesFilter  @.Filters           is xml-element('item')               is xml-skip-null    is xml-container('filterSet')           is rw;
  has Str                          @.InstanceTypes     is xml-element('item')               is xml-skip-null    is xml-container('instanceTypeSet')     is rw;  #= sub:Amazon::AWS::EC2::validInstanceTypes::checkInstanceType
  has Int                          $.MaxResults        is xml-element                       is xml-skip-null                                            is rw;
  has Str                          $.NextToken         is xml-element                       is xml-skip-null                                            is rw;

  submethod BUILD (
    :$dryRun,
    :@filters         is copy,
    :@instanceTypes   is copy,
    # For testing purposes only.
    :$!DryRun         =  False,
    :@!Filters,
    :@!InstanceTypes,
    :$!MaxResults     =  1000,
  ) {
    $!DryRun     = $dryRun     if $dryRun;

    if @instanceTypes {
      @!InstanceTypes = @instanceTypes.map({
        when Str                               { $_ }
        when Amazon::AWS::EC2::Types::Instance { .instanceType }

        # Can't use errBadContents() here due to extra types.
        # ... yet
        default {
          die qq:to/DIE/.chomp;
    Invalid value passed to \@instanceType. Should only contain Instance Types, or Instance objects.
    Instead it contains:
    { @instanceTypes.map( *.^name ).unique.join(', ') }
    DIE

        }
      });
    }

    if @filters {
      @!Filters = do given @filters {
        when .all ~~ DescribeInstanceTypesFilter { $_ }

        default { errorBadContents(@filters, DescribeInstanceTypesFilter) }
      };
    }
  }

  method run (Str :$nextToken is copy, :$raw = False)
    is also<
      do
      execute
    >
  {
    $nextToken //= '';

    my ($cnt, @FilterArgs) = (1);
    for @!Filters {
      @FilterArgs.push: Pair.new("Filter.{$cnt++}.{.key}", urlEncode(.value))
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
