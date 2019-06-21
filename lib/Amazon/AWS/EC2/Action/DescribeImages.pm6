use v6.c;

use XML::Class;
use Method::Also;

use Amazon::AWS::EC2::Types::Instance;

use Amazon::AWS::EC2::Filters::DescribeImagesFilter;
use Amazon::AWS::EC2::Response::DescribeImagesResponse;
use Amazon::AWS::Roles::Eqv;
use Amazon::AWS::Utils;

class Amazon::AWS::EC2::Action::DescribeImages is export
  does XML::Class[
    xml-element   => 'DescribeInstances',
    xml-namespace => 'http://ec2.amazonaws.com/doc/2016-11-15/'
  ]
{
  also does Amazon::AWS::Roles::Eqv;

  my $c = ::?CLASS.^name.split('::')[* - 1];

  has Bool                   $.DryRun                                            is xml-element                  is rw;
  has DescribeImagesFilter   @.Filters       is xml-container('filterSet')       is xml-element                  is rw;
  has Str                    @.ExecutableBy  is xml-container('executableBySet') is xml-element('executableBy')  is rw;
  has Str                    @.ImageIds      is xml-container('imageIdSet')      is xml-element('imageId')       is rw;
  has Str                    @.Owners        is xml-container('ownerSet')        is xml-element('owner')         is rw;
  has Int                    $.MaxResults    is xml-element                      is xml-element                  is rw;

  # How to handle use of nextToken? -- TBD
  # Ways to handle: - Max number of requests
  #                 - All in one (no user control)
  #                 - One page (and then pass the next token).

  submethod BUILD (
    :$dryRun,
    :@filters       is copy,
    :@executableBy  is copy,
    :@imageIds      is copy,
    :$maxResults,
    :@owners        is copy,
    # For testing purposes only.
    :$!DryRun               = False,
    :@!Filters,
    :@!ExecutableBy,
    :@!ImageIds,
    :@!Owners               = ('self').Array, 
    :$!MaxResults           = 1000,
    
  ) {
    if @imageIds {
      @!ImageIds = @imageIds.map({
        when Str                               { $_ }
        when Amazon::AWS::EC2::Types::Instance { .imageId }
        when Amazon::AWS::EC2::Types::Image    { .imageId }

        default {
          die qq:to/DIE/.chomp;
    Invalid value passed to \@instances. Should only contain InstanceIds or Instance objects, but contains:
    { @imageIds.map( *.^name ).unique.join(', ') }
    DIE

        }
      });
    }

    if @executableBy {
      @!ExecutableBy = @executableBy.map({
        do {
          when Str { $_ }

          default {
            die qq:to/DIE/.chomp unless @executableBy.all ~~ Str;
      Invalid value passed to \@executableBy. Should only contain Strings but value provided contains:
      { @executableBy.map( *.^name ).unique.join(', ') }
      DIE

          }
        }
      });
    }

    if @owners {
      @!Owners = @owners.map({
        do {
          when Str { $_ }

          default {
            die qq:to/DIE/.chomp unless @owners.all ~~ Str;
      Invalid value passed to \@owners. Should only contain Strings but value provided contains:
      { @owners.map( *.^name ).unique.join(', ') }
      DIE

          }
        }
      });
    }

    if @filters {
      @!Filters = do given @filters {
        when .all ~~ Amazon::AWS::EC2::Filters::DescribeImagesFilter { $_ }

        default {
          die qq:to/DIE/.chomp;
          Invalid value passed to \@filers. Should only contain Filters::DescribeImageFilter objects, but contains:
          { @filters.map( *.^name ).unique.join('. ') }
          DIE

        }
      };
    }

  }

  method run (:$nextToken = '', :$raw = False)
    is also<
      do
      execute
    >
  {
    my $cnt = 1;
    my @ExecutableByArgs;
    @ExecutableByArgs.push: Pair.new("ExecutableBy.{$cnt++}", $_) for @.ExecutableBy;

    my @FilterArgs;
    $cnt = 1;
    for @.Filters {
      @FilterArgs.push: Pair.new("Filter.{$cnt++}.{.key}", .value) for .pairs;
    }

    $cnt = 1;
    my @ImageIdArgs;
    @ImageIdArgs.push: Pair.new("ImageId.{$cnt++}", $_) for @.ImageIds;

    $cnt = 1;
    my @OwnerArgs;
    @OwnerArgs.push: Pair.new("Owner.{$cnt++}", $_) for @.Owners;

    # Should already be sorted.
    my @args;

    if $nextToken.chars {
      @args = ( nextToken => $nextToken );
    } else {
      @args = (
        DryRun         => $.DryRun,
        |@ExecutableByArgs,
        |@FilterArgs,
        |@ImageIdArgs,
        |@OwnerArgs,
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
