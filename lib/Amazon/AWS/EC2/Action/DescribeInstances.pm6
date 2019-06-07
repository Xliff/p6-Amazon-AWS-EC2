use v6.c;

use Method::Also;

use Amazon::AWS::Utils;
#use Amazon::AWS::EC2::Filter;
use Amazon::AWS::EC2::Response::DescribeInstances;

class Amazon::AWS::EC2::Action::DescribeInstances is export {
  has Bool    $.DryRun;
#  has Filter  @.filters;
  has Str     @.InstanceIds;
  has Int     $.maxResults;
  has Str     $.nextToken;

  # How to handle use of nextToken? -- TBD
  # Ways to handle: - Max number of requests
  #                 - All in one (no user control)
  #                 - One page (and then pass the next token).

  submethod BUILD (
    :$!DryRun     = False,
    :$!maxResults = 1000,
    :$!nextToken  = '',
    :@filters,
    :@instances,
  ) {
    @!InstanceIds = do given @instances {
      when .all ~~ Str                        { @instances                     }
      when .all ~~ Amazon::AWS::EC2::Instance { @instances.map( *.instanceID ) }

      default {
        die qq:to/DIE/.chomp;
        Invalid value passed to \@instances. Should only contain Instance objects, but contains:
        { @instances.map( *.^name ).unique.join(', ') }
        DIE

      }
    };

    # @filters = do given @filters {
    #   when .all ~~ Amazon::AWS::EC2::Filter { @filters }
    #
    #   default {
    #     die qq:to/DIE/.chomp;
    #     Invalid value passed to \@filers. Should only contain Filter objects, but contains:
    #     { @filters.map( *.^name ).unique.join('. ') }
    #     DIE
    #
    #   }
    # };

  }

  method run (:$nextToken = '')
    is also<
      do
      execute
    >
  {
    die 'Cannot use @.instances and $.maxResults in the same call to DescribeInstances'
      if $.maxResults.defined && @.InstanceIds;

    my $c = 1;
    my @InstanceArgs;
    @InstanceArgs.push: Pair.new("InstanceId.{$c++}", $_) for @.InstanceIds;

    my @Filters;
    # Handle filters

    # Should already be sorted.
    my @args;

    if $nextToken.chars {
      @args = ( nextToken => $nextToken );
    } else {
      @args = (
        DryRun         => $.DryRun,
        |@InstanceArgs,
        |@Filters,
        MaxResults     => $.maxResults,
        Version        => '2016-11-15'
      );
    }

    # XXX - Add error handling to makeRequest!
    Amazon::AWS::EC2::Response::DescribeInstances.from-xml(
      makeRequest(
        "?Action=DescribeInstances&{ @args.map({ "{.key}={.value}" }).join('&') }"
      )
    );
  }

}
