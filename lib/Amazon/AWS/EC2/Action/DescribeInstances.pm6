use v6.d;

use XML::Class;
use Method::Also;

use Amazon::AWS::EC2::Types::Volume;

use Amazon::AWS::Utils;
use Amazon::AWS::Roles::Eqv;

use Amazon::AWS::EC2::Filters::DescribeInstancesFilter;
use Amazon::AWS::EC2::Response::DescribeInstancesResponse;

class Amazon::AWS::EC2::Action::DescribeInstances is export
  does XML::Class[
    xml-element   => 'DescribeInstances',
    xml-namespace => 'http://ec2.amazonaws.com/doc/2016-11-15/'
  ]
{
  also does Amazon::AWS::Roles::Eqv;

  my $c = ::?CLASS.^name.split('::')[* - 1];

  has Bool                     $.DryRun                                        is xml-element         is rw;
  has DescribeInstancesFilter  @.Filters     is xml-container('filterSet')     is xml-element         is rw;
  has Str                      @.InstanceIds is xml-container('instanceIdSet') is xml-element('item') is rw;
  has Int                      $.MaxResults                                    is xml-element         is rw;
  #has Str                      $.NextToken                                     is xml-element         is rw;

  # How to handle use of nextToken? -- TBD
  # Ways to handle: - Max number of requests
  #                 - All in one (no user control)
  #                 - One page (and then pass the next token).

  submethod BUILD (
    :$dryRun,
    :@filters,
    :@instances,
    :$maxResults,
    :$nextToken,
    # For testing purposes only
    :$!DryRun     = False,
    :@!Filters,
    :@!InstanceIds,
    :$!MaxResults = 1000,
    # :$!NextToken  = '',
  ) {
    $!DryRun     = $dryRun     if $dryRun;
    
    if @instances {
      @!InstanceIds = @instances.map({
        do {
          when Str      { $_          }
          when Instance { .instanceID }
          when Volume   { .attachments.map( *.instanceId ) }

          default {
            die qq:to/DIE/.chomp;
            Invalid value passed to \@instances. Should only contain Instance objects, but contains:
            { @instances.map( *.^name ).unique.join(', ') }
            DIE

          }
        }
      }).flat;
    }

    if @filters {
      @!Filters = do given @filters {
        when .all ~~ Amazon::AWS::EC2::Filters::DescribeInstancesFilter
          { @filters }

        default {
          die qq:to/DIE/.chomp;
          Invalid value passed to \@filers. Should only contain DescribeInstancesFilter objects, but also contains:
          { @filters.grep( * !~~ DescribeInstancesFilter ).map( *.^name ).unique.join('. ') }
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
    die 'Cannot use @.instances and $.maxResults in the same call to DescribeInstances'
      if $!MaxResults.defined && @!InstanceIds;

    my $cnt = 1;
    my @InstanceArgs;
    @InstanceArgs.push: Pair.new("InstanceId.{$cnt++}", $_) for @!InstanceIds;

    my @FilterArgs;
    $cnt = 1;
    for @!Filters {
      @FilterArgs.push: Pair.new("Filter.{$cnt++}.{.key}", urlEncode(.value)) 
        for .pairs;
    }

    # Should already be sorted.
    my @args;

    if $nextToken.chars {
      @args = ( nextToken => $nextToken );
    } else {
      @args = (
        DryRun         => $!DryRun,
        |@InstanceArgs,
        |@FilterArgs,
        MaxResults     => $!MaxResults,
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
