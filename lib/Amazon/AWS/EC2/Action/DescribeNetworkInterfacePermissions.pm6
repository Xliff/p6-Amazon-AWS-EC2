use v6.d;

use XML::Class;
use Method::Also;

use Amazon::AWS::Utils;
use Amazon::AWS::Roles::Eqv;

use Amazon::AWS::EC2::Filters::DescribeNetworkInterfacePermissionsFilter;
use Amazon::AWS::EC2::Response::DescribeNetworkInterfacePermissionsResponse;

use Amazon::AWS::EC2::Types::Volume;

class Amazon::AWS::EC2::Action::DescribeNetworkInterfacePermissions is export
  does XML::Class[
    xml-element   => 'DescribeNetworkInterfacePermissions',
    xml-namespace => 'http://ec2.amazonaws.com/doc/2016-11-15/'
  ]
{
  also does Amazon::AWS::Roles::Eqv;

  my $c = ::?CLASS.^name.split('::')[* - 1];

  has Bool                                       $.DryRun                                                                   is xml-element         is rw;
  has DescribeNetworkInterfacePermissionsFilter  @.Filters                        is xml-container('filterSet')             is xml-element         is rw;
  has Str                                        @.NetworkInterfacePermissionIds  is xml-container('networkInterfaceIdSet') is xml-element('item') is rw;
  has Int                                        $.MaxResults                                                               is xml-element         is rw;

  # How to handle use of nextToken? -- TBD
  # Ways to handle: - Max number of requests
  #                 - All in one (no user control)
  #                 - One page (and then pass the next token).

  submethod BUILD (
    :$dryRun,
    :@filters,
    :@networkInterfacePermissionIds,
    :$maxResults,
    # For testing purposes only
    :@!Filters,
    :$!DryRun                        = False,
    :@!NetworkInterfacePermissionIds,
    :$!MaxResults                    = 50
  ) {
    $!DryRun     = $dryRun     if $dryRun;
    $!MaxResults = $maxResults if $maxResults.defined;

    die '$maxResutlts must be an integer between 5 and 255'
      unless $!MaxResults ~~ 5..255;

    if @networkInterfacePermissionIds {
      @!NetworkInterfacePermissionIds = @networkInterfacePermissionIds.map({
        do {
          when Str  { $_ }

          default   {
            die qq:to/DIE/.chomp;
             Invalid value passed to \@networkInterfacePermissionIds. Should only contain Str objects, but contains:
            { @networkInterfacePermissionIds.grep( * !~~ Str ).map( *.^name ).unique.join(', ') }
            DIE

          }
        }
      }).flat;
    }

    if @filters {
      @!Filters = do given @filters {
        when .all ~~ Amazon::AWS::EC2::Filters::DescribeNetworkInterfacePermissionsFilter { @filters }

        default {
          die qq:to/DIE/.chomp;
          Invalid value passed to \@filers. Should only contain DescribeNetworkInterfacePermissionsFilter objects, but contains:
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
    # cw: Not mentioned at https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_DescribeNetworkInterfacePermissions.html
    # but left in case it was an oversight.
    #
    # die 'Cannot use @.NetworkInterfaceIds and $.maxResults in the same call to DescribeNetworkInterfacePermissions'
    #   if $.MaxResults.defined && @.NetworkInterfaceIds;

    my $cnt = 1;
    my @NetworkPermissionIdArgs;
    @NetworkPermissionIdArgs.push: Pair.new("VpcId.{$cnt++}", $_)
      for @!NetworkInterfacePermissionIds;

    my @FilterArgs;
    $cnt = 1;
    for @!Filters {
      @FilterArgs.push: Pair.new("Filter.{$cnt}.{.key}", urlEncode(.value))
        for .pairs;
      $cnt++;
    }

    # Should already be sorted.
    my @args;

    if $nextToken.chars {
      @args = ( nextToken => $nextToken );
    } else {
      @args = (
        DryRun         => $!DryRun,
        |@FilterArgs,
        MaxResults     => $!MaxResults,
        |@NetworkPermissionIdArgs,
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
