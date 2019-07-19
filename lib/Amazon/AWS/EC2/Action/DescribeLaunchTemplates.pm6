use v6.c;

use XML::Class;
use Method::Also;

use Amazon::AWS::EC2::Types::Instance;

use Amazon::AWS::EC2::Filters::DescribeLaunchTemplatesFilter;
use Amazon::AWS::EC2::Response::DescribeLaunchTemplatesResponse;
use Amazon::AWS::Roles::Eqv;
use Amazon::AWS::Utils;

class Amazon::AWS::EC2::Action::DescribeLaunchTemplates is export
  does XML::Class[
    xml-element   => 'DescribeLaunchTemplates',
    xml-namespace => 'http://ec2.amazonaws.com/doc/2016-11-15/'
  ]
{
  also does Amazon::AWS::Roles::Eqv;

  my $c = ::?CLASS.^name.split('::')[* - 1];

  has Bool                            $.DryRun        is xml-element is xml-skip-null is rw;
  has Int                             $.MaxResults    is xml-element is xml-skip-null is rw;
  
  has DescribeLaunchTemplatesFilter   @.Filters       
    is xml-container('filterSet')       
    is xml-element
    is xml-skip-null
    is rw;
    
  has Str                             @.LaunchTemplateIds      
    is xml-container('launchTemplateIdSet')
    is xml-element('item')
    is xml-skip-null
    is rw;
    
  has Str                             @.LaunchTemplateNames
    is xml-container('launchTemplateNameSet')      
    is xml-element('item')
    is xml-skip-null
    is rw;

  # How to handle use of nextToken? -- TBD
  # Ways to handle: - Max number of requests
  #                 - All in one (no user control)
  #                 - One page (and then pass the next token).

  submethod BUILD (
    :$dryRun,
    :@filters,
    :@launchTemplateIds,
    :@launchTemplateNames,
    :$maxResults,
    # For testing purposes only.
    :$!DryRun = False,
    :@!Filters,
    :@!LaunchTemplateIds,
    :@!LaunchTemplateNames,
    :$!MaxResults = 200,
  ) {
    $!DryRun     = $dryRun     if $dryRun;
    $!MaxResults = $maxResults if $maxResults.defined;
    
    die 'MaxResults must be an integer from 1..200'
      unless $!MaxResults ~~ 1..200;
    
    if @launchTemplateIds {
      @!LaunchTemplateIds = @launchTemplateIds.map({
        when Str  { $_ }
        default   { errorBadContents(@launchTemplateIds, Str) }
      });
    }

    if @launchTemplateNames {
      @!LaunchTemplateNames = @launchTemplateNames.map({
        do {
          # Pattern: Valid launchTemplateName
          when Str  { die "Invalid characters found in '{$_}'"
                        unless /^ /<[ a..z A..Z 0..9 ( ) . \- / _ ]>+ $/; 
                      $_; }
                      
          default   { errorBadContents(@launchTemplateNames, Str) }
        }
      });
    }

    if @filters {
      @!Filters = do given @filters {
        when .all ~~ DescribeLaunchTemplatesFilter { $_ }

        default { errorBadContents(@filters, DescribeLaunchTemplatesFilter) }
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
    
    my $cnt = 1;
    my @LaunchTemplateNamesArgs;
    # Needs encoding!
    @LaunchTemplateNamesArgs.push: 
      Pair.new("LaunchTemplateNames.{$cnt++}", urlEncode($_))
        for @!LaunchTemplateNames;

    my @FilterArgs;
    $cnt = 1;
    for @!Filters {
      @FilterArgs.push: Pair.new("Filter.{$cnt++}.{.key}", urlEncode(.value)) 
        for .pairs;
    }

    $cnt = 1;
    my @LaunchTemplateIdsArgs;
    @LaunchTemplateIdsArgs.push: Pair.new("LaunchTemplateId.{$cnt++}", $_) 
      for @!LaunchTemplateIds;

    # Should already be sorted.
    my @args;

    if (my $nt = $nextToken.trim).chars {
      @args = ( nextToken => $nt );
    } else {
      @args = (
        DryRun         => $!DryRun,
        |@FilterArgs,
        |@LaunchTemplateIdsArgs,
        |@LaunchTemplateNamesArgs,
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
