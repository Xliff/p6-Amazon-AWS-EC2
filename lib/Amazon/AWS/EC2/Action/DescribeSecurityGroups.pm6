use v6.c;

use XML::Class;
use Method::Also;

use Amazon::AWS::EC2::Types::GroupIdentifier;

use Amazon::AWS::EC2::Filters::DescribeSecurityGroupsFilter;
use Amazon::AWS::EC2::Response::DescribeSecurityGroups;
use Amazon::AWS::Utils;

class Amazon::AWS::EC2::Action::DescribeSecurityGroups is export
  does XML::Class[
    xml-element   => 'DescribeInstances',
    xml-namespace => 'http://ec2.amazonaws.com/doc/2016-11-15/'
  ]
{
  my $c = ::?CLASS.^name.split('::')[* - 1];

  has Bool                          $.DryRun                                      is xml-element               is rw;
  has DescribeSecurityGroupsFilter  @.filters     is xml-container('filterSet')   is xml-element               is rw;
  has Str                           @.groupIds    is xml-container('groupIds')    is xml-element('groupId')    is rw;
  has Str                           @.groupNames  is xml-container('groupNames')  is xml-element('groupName')  is rw;
  has Int                           $.maxResults                                  is xml-element               is rw;
  has Str                           $.nextToken                                   is xml-element               is rw;

  # How to handle use of nextToken? -- TBD
  # Ways to handle: - Max number of requests
  #                 - All in one (no user control)
  #                 - One page (and then pass the next token).

  submethod BUILD (
    :$!DryRun     = False,
    :$!maxResults = 1000,
    :$!nextToken  = '',
    :@filters    is copy = (),
    :@groups     is copy = (),
    :@groupIds   is copy = (),
    :@groupNames is copy = ()
  ) {
    die ':$maxResults must be a number from 5 to 1000'
      unless $!maxResults ~~ 5..1000;

    for @groups {
      when GroupIdentifier {
        @!groupIds.push:   .groupId;
        @!groupNames.push: .groupNames;
      }
      default { die "Invalid value '{ ^.name }' in \@groups" }
    }

    @!groupIds = @groupIds.map({
      do {
        when Str             { $_       }
        when GroupIdentifier { .groupId }
        default              { die "Invalid type '{ .^name }' in \@groupIds!" }
      }
    }).unique;

    @!groupNames = @groupNames.= map({
      do {
        when Str             { $_       }
        when GroupIdentifier { .groupName }
        default              { die "Invalid type '{ .^name }' in \@groupNames!" }
      }
    }).unique;

    @filters = do given @filters {
      when .all ~~ Amazon::AWS::EC2::Filters::DescribeSecurityGroups { @filters }

      default {
        die qq:to/DIE/.chomp;
        Invalid value passed to \@filers. Should only contain Filters::DescribeSecurityGroup objects, but contains:
        { @filters.map( *.^name ).unique.join('. ') }
        DIE

      }
    };

  }

  method run (:$nextToken = '', :$raw = False)
    is also<
      do
      execute
    >
  {
    my $cnt = 1;
    my @GroupIdArgs;
    @GroupIdArgs.push: Pair.new("GroupId.{$c++}", $_) for @.groupIds;

    $cnt = 1;
    my @GroupNameArgs;
    @GroupNameArgs.push: Pair.new("GroupName.{$c++}", $_) for @.groupNames;

    my @FilterArgs;
    $cnt = 1;
    for @.filters {
      @FilterArgs.push: Pair.new("Filter.{$c++}.{.key}", .value) for .pairs;
    }

    # Should already be sorted.
    my @args;

    if $nextToken.chars {
      @args = ( nextToken => $nextToken );
    } else {
      @args = (
        DryRun         => $.DryRun,
        |@GroupIdArgs,
        |@GroupNameArgs,
        |@FilterArgs,
        MaxResults     => $.maxResults,
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
      Amazon::AWS::EC2::Response::DescribeSecurityGroupsResponse.from-xml($xml);
  }

}
