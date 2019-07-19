use v6.c;

use XML::Class;
use Method::Also;

use Amazon::AWS::EC2::Types::Instance;

use Amazon::AWS::EC2::Filters::DescribeLaunchTemplateVersionsFilter;
use Amazon::AWS::EC2::Response::DescribeLaunchTemplateVersionsResponse;
use Amazon::AWS::Roles::Eqv;
use Amazon::AWS::Utils;

class Amazon::AWS::EC2::Action::DescribeLaunchTemplateVersions is export
  does XML::Class[
    xml-element   => 'DescribeLaunchTemplateVersions',
    xml-namespace => 'http://ec2.amazonaws.com/doc/2016-11-15/'
  ]
{
  also does Amazon::AWS::Roles::Eqv;

  my $c = ::?CLASS.^name.split('::')[* - 1];

  has Bool  $.DryRun             is xml-element is xml-skip-null is rw;
  has Int   $.MaxResults         is xml-element is xml-skip-null is rw;
  has Str   $.LaunchTemplateId   is xml-element is xml-skip-null is rw;
  has Str   $.LaunchTemplateName is xml-element is xml-skip-null is rw;
  has Int   $.MaxVersion         is xml-element is xml-skip-null is rw;
  has Int   $.MinVersion         is xml-element is xml-skip-null is rw;
  
  has DescribeLaunchTemplateVersionsFilter @.Filters       
    is xml-container('filterSet')       
    is xml-element
    is xml-skip-null
    is rw;
    
  has Str @.LaunchTemplateVersions      
    is xml-container('launchTemplateVersionSet')
    is xml-element('item')
    is xml-skip-null
    is rw;

  # How to handle use of nextToken? -- TBD
  # Ways to handle: - Max number of requests
  #                 - All in one (no user control)
  #                 - One page (and then pass the next token).

  submethod BUILD (
    :$dryRun,
    :$maxResults,
    :$launchTemplateId,
    :$launchTemplateName,
    :$maxVersion,
    :$minVersion,
    :@filters,
    :@launchTemplateVersions,
    # For testing purposes only.
    :$!DryRun                 = False,
    :$!MaxResults             = 200,
    :$!LaunchTemplateId       = '',
    :$!LaunchTemplateName     = '',
    :$!MaxVersion             = 0,
    :$!MinVersion             = 0,
    :@!Filters,
    :@!LaunchTemplateVersions
  ) {
    $!DryRun     = $dryRun     if $dryRun;
    $!MaxResults = $maxResults if $maxResults.defined;
    $!MinVersion = $minVersion if $minVersion.defined;
    $!MaxVersion = $maxVersion if $maxVersion.defined;
    
    $!LaunchTemplateId   = $launchTemplateId.trim
      if $launchTemplateId.defined   && $launchTemplateId.trim.chars;
    $!LaunchTemplateName = $launchTemplateName.trim
      if $launchTemplateName.defined && $launchTemplateName.trim.chars;
    
    # Pattern: Valid launchTemplateName
    die "Invalid LaunchTemplateName: '{ $!LaunchTemplateName }'"
      unless $!LaunchTemplateName.chars.not || 
             $!LaunchTemplateName ~~ /^ <[ a..z A..Z 0..9 ( ) . \- / _ ]>+ $/;
    
    die 'MaxResults must be an integer from 1..200'
      unless $!MaxResults ~~ 1..200;
      
    if @launchTemplateVersions {
      @!LaunchTemplateVersions = @launchTemplateVersions.map({
        do {
          when Int  { $_ }
          default   { errorBadContents(@launchTemplateVersions, Int) }
        }
      });
    }

    if @filters {
      @!Filters = do given @filters {
        when .all ~~ DescribeLaunchTemplateVersionsFilter { $_ }

        default { 
          errorBadContents(@filters, DescribeLaunchTemplateVersionsFilter) 
        }
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

    my @FilterArgs;
    my $cnt = 1;
    for @!Filters {
      @FilterArgs.push: Pair.new("Filter.{$cnt++}.{.key}", urlEncode(.value)) 
        for .pairs;
    }

    $cnt = 1;
    my @LaunchTemplateVersionArgs;
    @LaunchTemplateVersionArgs.push: 
      Pair.new("LaunchTemplateVersion.{$cnt++}", $_) 
        for @!LaunchTemplateVersions;

    # Should already be sorted.
    my @args;

    if (my $nt = $nextToken.trim).chars {
      @args = ( nextToken => $nt );
    } else {
      @args = (
        DryRun => $!DryRun,
        |@FilterArgs
      );
      @args.push: (LaunchTemplateId   => $!LaunchTemplateId) 
        if $!LaunchTemplateId.chars;
      @args.push: (LaunchTemplateName => urlEncode($!LaunchTemplateName))
        if $!LaunchTemplateName.chars;
      @args.append: @LaunchTemplateVersionArgs 
        if @LaunchTemplateVersionArgs;
      @args.push: (MaxResults => $!MaxResults) if $!MaxResults;
      @args.push: (MinVersion => $!MinVersion) if $!MinVersion;
      @args.push: (Version    => '2016-11-15');
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
