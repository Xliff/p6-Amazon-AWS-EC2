use v6.c;

use XML::Class;
use Method::Also;

use Amazon::AWS::EC2::Types::GroupIdentifier;

use Amazon::AWS::EC2::Filters::DescribeSecurityGroupsFilter;
use Amazon::AWS::EC2::Response::DescribeSecurityGroupsResponse;

use Amazon::AWS::Utils;

use Amazon::AWS::Roles::Eqv;
                                
class Amazon::AWS::EC2::Action::DescribeSecurityGroups is export
  does XML::Class[
    xml-element   => 'DescribeSecurityGroups',
    xml-namespace => 'http://ec2.amazonaws.com/doc/2016-11-15/'
  ]
{
  also does Amazon::AWS::Roles::Eqv;

  my $c = ::?CLASS.^name.split('::')[* - 1];

  has Bool                          $.DryRun                                      is xml-element                      is xml-skip-null is rw;
  has DescribeSecurityGroupsFilter  @.Filters     is xml-container('filterSet')   is xml-element('item', :over-ride)  is xml-skip-null is rw;
  has Str                           @.GroupIds    is xml-container('groupIds')    is xml-element('item', :over-ride)  is xml-skip-null is rw;
  has Str                           @.GroupNames  is xml-container('groupNames')  is xml-element('item', :over-ride)  is xml-skip-null is rw;
  has Int                           $.MaxResults                                  is xml-element                      is xml-skip-null is rw;

  # How to handle use of nextToken? -- TBD
  # Ways to handle: - Max number of requests
  #                 - All in one (no user control)
  #                 - One page (and then pass the next token).

  submethod BUILD (
    :$dryRun,
    :@filters,
    :@groups,
    :@groupIds,
    :@groupNames,
    :$maxResults,
    # For testing purposes, only!
    :$!DryRun     = False,
    :@!Filters,
    :@!GroupIds,
    :@!GroupNames,
    :$!MaxResults = 1000,
    #:$!NextToken  = '',
  ) {
    if $maxResults.defined {
      die ':$maxResults must be a number from 5 to 1000'
        unless $maxResults ~~ 5..1000;
      $!MaxResults = $maxResults;
    }
      
   # Will MaxResults work with @!GroupIds?

    for @groups {
      when GroupIdentifier {
        @!GroupIds.push:   .groupId    if .groupId.defined;
        @!GroupNames.push: .groupNames if .groupName.defined;
      }
      default { die "Invalid value '{ ^.name }' in \@groups" }
    }

    if @groupIds {
      @!GroupIds = @groupIds.map({
        do {
          when Str             { $_       }
          when GroupIdentifier { .groupId }
          default              { die "Invalid type '{ .^name }' in \@groupIds!" }
        }
      }).unique;
    }

    if @groupNames {
      @!GroupNames = @groupNames.map({
        do {
          when Str             { $_       }
          when GroupIdentifier { .groupName }
          default              { die "Invalid type '{ .^name }' in \@groupNames!" }
        }
      }).unique;
    }

    if @filters {
      @!Filters = do given @filters {
        when .all ~~ DescribeSecurityGroupsFilter    { $_ }

        default {
          die qq:to/DIE/.chomp;
          Invalid value passed to \@filers. Should only contain Filters::DescribeSecurityGroupFilter objects, but contains:
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
    my @GroupIdArgs;
    @GroupIdArgs.push: Pair.new("GroupId.{$cnt++}", $_) for @.GroupIds;

    $cnt = 1;
    my @GroupNameArgs;
    @GroupNameArgs.push: Pair.new("GroupName.{$cnt++}", $_) for @.GroupNames;

    my @FilterArgs;
    $cnt = 1;
    for @.Filters {
      @FilterArgs.push: Pair.new("Filter.{$cnt++}.{.key}", .value) for .pairs;
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
        MaxResults     => $.MaxResults,
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
      # This is a problem for this compunit ONLY. Why?
      #::("Amazon::AWS::EC2::Response::{ $c }Response").from-xml($xml);
      ::("{ $c }Response").from-xml($xml);
  }

}
