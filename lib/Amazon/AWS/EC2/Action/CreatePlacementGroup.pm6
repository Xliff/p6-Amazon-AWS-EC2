use v6.d;

use Method::Also;

use XML::Class;

use Amazon::AWS::Utils;
use Amazon::AWS::Roles::Eqv;

use Amazon::AWS::EC2::Response::CreatePlacementGroupResponse;

my %attributes;

class Amazon::AWS::EC2::Action::CreatePlacementGroup is export
  does XML::Class[
    xml-element   => 'CreatePlacementGroup',
    xml-namespace => 'http://ec2.amazonaws.com/doc/2016-11-15/'
  ]
{
  also does Amazon::AWS::Roles::Eqv;

  my $c = ::?CLASS.^name.split('::')[* - 1];

  has Bool $.DryRun         is xml-element is xml-skip-null is rw;
  has Str  $.GroupName      is xml-element is xml-skip-null is rw;
  has Int  $.PartitionCount is xml-element is xml-skip-null is rw;
  has Str  $.Strategy       is xml-element is xml-skip-null is rw;  #= cluster | spread | partition

  submethod BUILD (
    :$dryRun,
    :$groupName,
    :$partitionCount,
    :$strategy,
    # For deserialization purposes, only!
    :$!DryRun         = False,
    :$!GroupName      = '',
    :$!PartitionCount = 0,
    :$!Strategy       = ''
  ) { 
    $!DryRun         = $dryRun         if $dryRun;
    $!PartitionCount = $partitionCount if $partitionCount;
    
    $!GroupName = $groupName.trim 
      if $groupName.defined && $groupName.trim.chars;
    $!Strategy = $strategy.trim  
      if $strategy.defined && $strategy.trim.chars;
      
    my $dieMsg = qq:to/DIE/;
      Strategy value '{ $!Strategy }' is not valid. Valid values are:
      { %attributes<Strategy|Table> }
      DIE
      
    die $dieMsg unless $!Strategy.chars.not ||
                       $!Strategy ~~ self.getValidStrategyValues.any;
  }

  method run (:$raw)
    is also<
      do
      execute
    >
  {
    # Encountered during .run testing:
    # Additional Error Message(s):
    # - The request must contain the parameter Strategy (MissingParameter)
    die 'Strategy is required!' unless $!Strategy.chars;
    
    die 'PartitionCount is invalid unless Stragegy is set to "partition"'
      if $!PartitionCount && $!Strategy ne 'partition';

    # Should already be sorted.
    my @args = (
      DryRun  => $!DryRun
    );
    @args.push: (GroupName      => urlEncode($!GroupName)) if $!GroupName.chars;
    @args.push: (PartitionCount => $!PartitionCount)       if $!PartitionCount;
    @args.push: (Strategy       => $!Strategy);
    @args.push: (Version        => '2016-11-15');
   
    # XXX - Add error handling to makeRequest!
    my $xml = makeRequest(
      "?Action={ $c }&{ @args.map({ "{.key}={.value}" }).join('&') }"
    );

    $raw ??
      $xml
      !!
      ::("Amazon::AWS::EC2::Response::{ $c }Response").from-xml($xml);
  }
  
  method getValidStrategyValues {
    %attributes<Strategy|ValidValues>.Array;
  }

}

BEGIN {
  %attributes = getAttributeData(
    Amazon::AWS::EC2::Action::CreatePlacementGroup
  );
}
