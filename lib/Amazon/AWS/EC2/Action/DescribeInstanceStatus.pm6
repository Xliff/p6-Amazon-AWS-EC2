use v6.c;

use XML::Class;
use Method::Also;

use Amazon::AWS::EC2::Filters::DescribeInstanceStatusFilter;
use Amazon::AWS::EC2::Response::DescribeInstanceStatusResponse;
use Amazon::AWS::EC2::Types::Instance;
use Amazon::AWS::EC2::Types::Volume;
use Amazon::AWS::Utils;
use Amazon::AWS::Roles::Eqv;

class Amazon::AWS::EC2::Action::DescribeInstanceStatus is export
  does XML::Class[
    xml-element   => 'DescribeInstanceStatus',
    xml-namespace => 'http://ec2.amazonaws.com/doc/2016-11-15/'
  ]
{
  also does Amazon::AWS::Roles::Eqv;

  my $c = ::?CLASS.^name.split('::')[* - 1];

  has Bool                          $.DryRun                                                   is xml-element               is rw;
  has DescribeInstanceStatusFilter  @.filters                is xml-container('filterSet')     is xml-element               is rw;
  has Bool                          $.IncludeAllInstances                                      is xml-element               is rw;
  has Str                           @.InstanceIds            is xml-container('instanceIdSet') is xml-element('instanceId') is rw;
  has Int                           $.maxResults                                               is xml-element               is rw;
  has Str                           $.nextToken                                                is xml-element               is rw;

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
    :$includeAll;
    :$includeAllInstances,
  ) {
    $!IncludeAllInstances = $includeAll // $includeAllInstances // False;

    @!InstanceIds = @instances.map({
      do {
        when Str      { $_           }
        when Instance { .instanceID }
        when Volume   { .attachments.map( *.instanceId ) }

        default {
          die qq:to/DIE/.chomp;
          Invalid value passed to \@instances. Should only contain instance-id compatible objects, but contains:
          { @instances.map( *.^name ).unique.join(', ') }
          DIE

        }
      }
    }).flat;

    @filters = do given @!filters {
      when .all ~~ Amazon::AWS::EC2::Filters::DescribeInstanceStatusFilter { @!filters }

      default {
        die qq:to/DIE/.chomp;
        Invalid value passed to \@filers. Should only contain DescribeInstancsStatusFilter objects, but contains:
        { @filters.map( *.^name ).unique.join('. ') }
        DIE

      }
    };

  }

  method run (:$nextToken = '', :$raw)
    is also<
      do
      execute
    >
  {
    die 'Cannot use @.instances and $.maxResults in the same call to DescribeInstanceStatus'
      if $.maxResults.defined && @.InstanceIds;

    my $cnt = 1;
    my @InstanceArgs;
    @InstanceArgs.push: Pair.new("InstanceId.{$cnt++}", $_) for @.InstanceIds;

    my @FilterArgs;
    $cnt = 1;
    for @!filters {
      @FilterArgs.push: Pair.new("Filter.{$cnt++}.{.key}", .value) for .pairs;
    }

    # Should already be sorted.
    my @args;

    if $nextToken.chars {
      @args = ( nextToken => $nextToken );
    } else {
      @args = (
        DryRun              => $.DryRun,
        IncludeAllInstances => $!IncludeAllInstances,
        |@InstanceArgs,
        |@FilterArgs,
        MaxResults          => $.maxResults,
        Version             => '2016-11-15'
      );
    }

    # XXX - Add error handling to makeRequest!
    my $xml = makeRequest(
      "?Action={ $c }&{ @args.map({ "{.key}={.value}" }).join('&') }"
    );

    $raw ??
      $xml
      !!
      Amazon::AWS::EC2::Response::DescribeInstanceStatusResponse.from-xml($xml);
  }

}