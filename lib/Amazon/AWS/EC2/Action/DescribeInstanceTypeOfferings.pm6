use v6.d;

use Amazon::AWS::EC2::Types::Base;

use Method::Also;
use XML::Class;

use Amazon::AWS::Utils;
use Amazon::AWS::Roles::Eqv;

use Amazon::AWS::EC2::Filters::DescribeInstanceTypeOfferingsFilter;
use Amazon::AWS::EC2::Response::DescribeInstanceTypeOfferingsResponse;

class Amazon::AWS::EC2::Action::DescribeInstanceTypeOfferings is export
  does XML::Class[xml-element => 'item']
{
  also is Amazon::AWS::EC2::Types::Base;

  my $c = ::?CLASS.^shortname;

  has Bool                                 $.DryRun          is xml-element                       is xml-skip-null                                      is rw;
  has DescribeInstanceTypeOfferingsFilter  @.Filters         is xml-element('item', :over-ride)   is xml-skip-null    is xml-container('filterSet')     is rw;
  has Str                                  $.LocationType    is xml-element                       is xml-skip-null                                      is rw;   #=  region | availability-zone | availability-zone-id
  has Int                                  $.MaxResults      is xml-element                       is xml-skip-null                                      is rw;
  has Str                                  $.NextToken       is xml-element                       is xml-skip-null                                      is rw;

  submethod BUILD (
    :$dryRun,
    :@filters         is copy,
    :$locationType,
    # For testing purposes only.
    :$!DryRun         =  False,
    :@!Filters,
    :$!LocationType   =  '',
    :$!MaxResults     =  1000,
  ) {
    $!DryRun       = $dryRun       if $dryRun;
    $!LocationType = $locationType if $locationType;

    if @filters {
      @!Filters = do given @filters {
        when .all ~~ DescribeInstanceTypeOfferingsFilter { $_ }

        default {
          errorBadContents(@filters, DescribeInstanceTypeOfferingsFilter)
        }
      }
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
        |@FilterArgs
      );
      @args.push(LocationType => $!LocationType) if $!LocationType;
      @args.push(Version      => '2016-11-15');
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
