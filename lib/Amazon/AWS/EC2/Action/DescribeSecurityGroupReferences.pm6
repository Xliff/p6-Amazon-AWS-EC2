use v6.c;

use Method::Also;
use XML::Class;

use Amazon::AWS::EC2::Response::DescribeSecurityGroupReferencesResponse;
use Amazon::AWS::EC2::Types::Instance;
use Amazon::AWS::Utils;

use Amazon::AWS::Roles::Eqv;

class Amazon::AWS::EC2::Action::DescribeSecurityGroupReferences is export
  does XML::Class[xml-element => 'DescribeSecurityGroupReferences']
{
  also does Amazon::AWS::Roles::Eqv;
  
  my $c = ::?CLASS.^name.split('::')[* - 1];

  has Bool                   $.DryRun                                        is xml-element             is rw;
  has Str                    @.GroupIds    is xml-container('GroupIdSet')    is xml-element('item')     is rw;

  submethod BUILD (
    :$dryRun,
    :@groupIds,
    # Testing purposes only!
    :$!DryRun = False,
    :@!GroupIds
  ) {
    # This can be expanded top anything that returns a regionId
    if @groupIds {
      die qq:to/DIE/.chomp unless @groupIds.all ~~ Str;
  Invalid value passed to \@groupIds. Should only strings, but also contains:
  { @groupIds.grep( * !~~ Str ).map( *.^name ).unique.join(', ') }
  DIE

      @!GroupIds = @groupIds;
    }
    
  }

  method run (:$raw = False)
    is also<
      do
      execute
    >
  {
    die 'A GroupId is required, and no such has yet been provided!'
      unless @.GroupIds;
    
    my $cnt = 1;
    my @GroupIdArgs;
    @GroupIdArgs.push: Pair.new("GroupId.{$cnt++}", $_) for @.GroupIds;

    # Should already be sorted.
    my @args = (
      DryRun         => $!DryRun,
      |@GroupIdArgs,
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
